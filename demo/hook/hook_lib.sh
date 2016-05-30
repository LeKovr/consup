echo "Hook start"

# X-Gogs-Event header
EVENT=$1

echo "Processing event ($EVENT)"

# Docker ENV
ROOT=$DISTRO_DIR
echo "Distro fetch root: $ROOT"

# ------------------------------------------------------------------------------
# All json payload
# echo "${HOOK_}" | jq '.'

# repository url
REPO=$(echo "${HOOK_}"  | jq -r '.repository.ssh_url')
# event type ("tag" etc)
RTYPE=$(echo "${HOOK_}" | jq -r '.ref_type')
# tag name
RNAME=$(echo "${HOOK_}" | jq -r '.ref')
# repository site, eg: "http://www.dev.lan"
RSITE=$(echo "${HOOK_}" | jq -r '.repository.website')

[[ "$RTYPE" == "null" ]] && RTYPE=tag
RNAME=${RNAME#refs/heads/}

cat <<EOF
Distros:  $DISTRO_DIR

Repo:  $REPO
Op:    $RTYPE
Tag:   $RNAME
Site:  $RSITE
--
PWD:   $PWD
EOF

KEY=/home/app/hook.key

# ------------------------------------------------------------------------------

if [[ "$EVENT" == "push" && "$RTYPE" == "tag" ]] ; then

  # tag.site
  DESTURI=${RNAME}.${RSITE#http://}
  DEST=${DESTURI%/}

  if [[ ${RNAME%-rm} != $RNAME ]] ; then
    echo "Branch $DEST remove requested"
    DEST=${RNAME%-rm}.${RSITE#http://}
    if [ -d $ROOT/$DEST ] ; then
      echo "Removing $DEST..."
      pushd $ROOT/$DEST
      make stop
      popd
      rm -rf $ROOT/$DEST
    fi
    echo "Hook cleanup complete"
    exit 0
  fi

  # consup domain on same host
  [[ "$CONSUP_ENV" ]] && REPO=${REPO/:/.web.service.consul:/}

  echo "Clone repo: $REPO"

  if [ -d $ROOT/$DEST ] ; then
    echo "Updating $DEST..."
    # just rm, no make stop - make start will do it anyway
    rm -rf $ROOT/$DEST
  else
    echo "Creating $DEST..."
    mkdir -p $ROOT || exit 1
  fi
  pushd $ROOT
  . /home/app/git.sh -i /home/app/hook.key clone --depth=1 --recursive --branch $RNAME $REPO $DEST || exit 1
  pushd $DEST
  if [ -f Makefile ] ; then
    echo "Setup site $DEST (${HOOK_db})"
    DB_NAME=${HOOK_db} APP_TAG="$RSITE" APP_SITE="$DEST" make setup
    TAG=${NODENAME}_$MODE
    # inspect myself and get host root
    DIR=$(docker inspect webhook_$TAG | jq -r ".[0].Mounts[].Source" | grep log/$TAG)
    HOST_ROOT=${DIR%/log/$TAG}${ROOT#/home/app}/$DEST
    echo "Host root: $HOST_ROOT"
    APP_ROOT=$HOST_ROOT make start-hook
  fi
  popd > /dev/null
  popd > /dev/null
fi

echo "Hook stop"
