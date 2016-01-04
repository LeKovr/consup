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

RTYPE=$(echo "${HOOK_}" | jq -r '.ref_type')
RNAME=$(echo "${HOOK_}" | jq -r '.ref')
REPO=$(echo "${HOOK_}"  | jq -r '.repository.ssh_url')
RUSER=$(echo "${HOOK_}" | jq -r '.repository.owner.username')
#  "http://www.dev.lan"
RSITE=$(echo "${HOOK_}" | jq -r '.repository.website')

cat <<EOF
Distros:  $DISTRO_DIR

Repo:  $REPO
Tag:   $RNAME
Op:    $RTYPE
User:  $RUSER
--
PWD:   $PWD
EOF

KEY=/home/app/hook.key

# ------------------------------------------------------------------------------

if [[ "$EVENT" == "push" && "$RTYPE" == "tag" ]] ; then
  DEST=$RNAME.$RUSER

  if [[ ${RNAME%-rm} != $RNAME ]] ; then
    DEST=${RNAME%-rm}.$RUSER
    echo "Branch $DEST remove requested"
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
  . /home/app/git.sh -i /home/app/hook.key clone --depth=1 --branch $RNAME $REPO $DEST || exit 1
  pushd $DEST
  if [ -f Makefile ] ; then
    NEWSITE=${RSITE/http:\/\/www/$DEST}
    echo "Setup site $NEWSITE"
    APP_TAG="$DEST" APP_SITE="$NEWSITE" make setup

    TAG=${NODENAME}_$MODE
    # inspect myself and get host root
    DIR=$(docker inspect webhook_$TAG | jq -r ".[0].Mounts[].Source" | grep log/$TAG)
    HOST_ROOT=${DIR%/log/$TAG}${ROOT#/home/app}/$DEST
    echo "Host root: $HOST_ROOT"
    APP_ROOT=$HOST_ROOT make start
  fi
  popd > /dev/null
  popd > /dev/null
fi

echo "Hook stop"
