#
# WebHook Continuous Intergation library
#
# ------------------------------------------------------------------------------

# strict mode http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# logging func
log() {
  D=$(date "+%F %T")
  echo  "$D $1"
}

# ------------------------------------------------------------------------------
# Parse STDIN as JSON and echo "name=value" pairs
kv2vars() {
  local key=$1
  echo "# Generated from KV store $key"
  jq -r '.[] | (.Key|ltrimstr("'$key'/")) +" "+  .Value ' | while read k v ; do
    val=$(echo -n "$v" | base64 -d)
    echo "$k=$val"
  done
}

# ------------------------------------------------------------------------------
# Parse STDIN as "name=value" pairs and PUT them into KV store
vars2kv() {
  local key=$1
  while read line ; do
    s=${line%%#*} # remove endline comments
    [ -n "${s##+([[:space:]])}" ] || continue # ignore line if contains only spaces
    name=${s%=*}
    val=${s#*=}
    #echo "=$name: $val="
    curl -s -X PUT -d "$val" http://localhost:8500/v1/kv/$key/$name > /dev/null || echo "err saving $name"
  done
}

# ------------------------------------------------------------------------------
# get application root from repo, tag and optional arg
# use only arg (withour repo and tag) if arg begins with "/"
# use "default" as arg value if it empty
mkroot() {
  local repo=$1
  local tag=$2
  local arg=$3

  local r0=${repo#*:}         # remove proto
  local repo_path=${r0%.git}  # remove suffix
  local res=""
  if [[ "$arg" != "${arg#/}" ]] ; then
    # ARG begins with /
    r0=${arg#/}
  else
    [[ "$arg" ]] || arg=default
    r0=$repo_path/$tag/$arg
  fi
  echo ${r0//\//--}
}

# ------------------------------------------------------------------------------
# Use .config if exists
# or load .config from KV store if key exists
# or generate default .config and save it to KV store
setup_config() {
  local key=$1
  local config=$2
  [[ "$config" ]] || config=.config

  # Get data from KV store
  local kv=$(curl -s http://localhost:8500/v1/kv/$key?recurse)

  if [[ ! "$kv" ]] ; then
    make $config
    echo "Load KV $key from $config"
    cat $config | vars2kv $key
  elif [ ! -f $config ] ; then
    echo "Save KV $key into $config"
    echo $kv | kv2vars $key > $config
  else
    echo "Use existing $config, ignore KV"
  fi
}
# setup_config tests:
# all empty - default .config generated & saved to KV
# only KV - .config loaded from KV
# only .config - .config saved to KV
# both exists - nothing changed

# ------------------------------------------------------------------------------

host_home_app() {

  # get webhook container id
  local container_id=$(cat /proc/self/cgroup | grep "cpu:/" | sed 's/\([0-9]\):cpu:\/docker\///g') # '
  # get host path for /home/app
  docker inspect $container_id | jq -r '.[0].Mounts[] | if .Destination == "/home/app" then .Source else empty end'
}

integrate() {

  local event=$1
  local is_consup=$2

  # Docker ENVs
  # $DISTRO_ROOT - git clone into /home/app/$DISTRO_DIR
  # DISTRO_CONFIG - file to save app config
  # SSH_KEY_NAME - ssh priv key in /home/app

  # All json payload
  # echo "${HOOK_}" | jq '.'

  # repository url
  local repo=$(echo "${HOOK_}" | jq -r '.repository.ssh_url')

  # event type ("tag" etc)
  local op=$(echo "${HOOK_}" | jq -r '.ref_type')
  [[ "$op" == "null" ]] && op="tag"

  if [[ "$event" != "push" || "$op" != "tag" ]] ; then
    log "Hook skipped - no event"
    exit 0
  fi

  # tag/branch name
  local tag=$(echo "${HOOK_}" | jq -r '.ref')
  tag=${tag#refs/heads/}

  local distro_path=$(mkroot $repo $tag ${HOOK_config})

  # consup domain on same host
  [[ "$is_consup" ]] && repo=${repo/:/.web.service.consul:/}

  local path=$DISTRO_ROOT/$distro_path

  # Cleanup old distro
  if [[ ${tag%-rm} != $tag ]] ; then
    local rmtag=${tag%-rm}
    distro_path=$(mkroot $repo $rmtag ${HOOK_config})

    log "Requested cleanup for $distro_path"
    path=$DISTRO_ROOT/$distro_path
    if [ -d $path ] ; then
      echo "Removing $distro_path..."
      pushd $path
      [ -f Makefile ] && make stop
      popd
      rm -rfd $path
    fi
    log "Hook cleanup complete"
    exit 0
  fi

  if [ -d $path ] ; then
    log "Updating $path..."
    # just rm, no make stop - make start will do it anyway
##    rm -rfd $path || { echo "mkdir error: $!" ; exit $? ; }
  else
    log "Creating $path..."
    mkdir -p $path || { echo "mkdir error: $!" ; exit $? ; }
  fi
  pushd $DISTRO_ROOT
    log "Clone $repo / $tag..."
##  . /home/app/git.sh -i $SSH_KEY_NAME clone --depth=1 --recursive --branch $tag $repo $distro_path || exit 1
  pushd $distro_path

  if [ -f Makefile ] ; then
    log "Setup $distro_path"

    setup_config conf/$distro_path $DISTRO_CONFIG

    # APP_ROOT - hosted application dirname for mount
    local host_root=$(host_home_app)
     APP_ROOT=$host_root/$DISTRO_ROOT/$distro_path make start-hook

  fi
  popd > /dev/null
  popd > /dev/null
  log "Hook stop"

}

