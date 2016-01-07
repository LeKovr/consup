
# Create user & his home dir

home=/home/app

# Check if user exists already
# grep -qe "^$APPUSER:" /etc/passwd || useradd -m -r -s /bin/bash -Gwww-data -gusers -gsudo $APPUSER
grep -qe "^$APPUSER:" /etc/passwd || useradd -d $home $APPUSER

chown $APPUSER /home/app

[ -f $home/.ssh/id_dsa ] || {
  gosu $APPUSER mkdir -p $home/.ssh
  gosu $APPUSER ssh-keygen -q -b 1024 -t dsa -f $home/.ssh/id_dsa -N ""
}

