
# Create user & his home dir

if [[ "$APPUSER" ]]; then
  home=/home/app/$APPUSER
  # Check if user exists already
  # grep -qe "^$APPUSER:" /etc/passwd || useradd -m -r -s /bin/bash -Gwww-data -gusers -gsudo $APPUSER
  grep -qe "^$APPUSER:" /etc/passwd || useradd -d $home $APPUSER
  if [ ! -d $home ] ; then
    mkdir -p $home
   chown $APPUSER $home
  fi
fi
