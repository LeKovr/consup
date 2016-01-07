
# Create user & his home dir

home=/home/app/$APPUSER

# Check if user exists already
# grep -qe "^$APPUSER:" /etc/passwd || useradd -m -r -s /bin/bash -Gwww-data -gusers -gsudo $APPUSER
grep -qe "^$APPUSER:" /etc/passwd || useradd -d $home $APPUSER

chown $APPUSER /home/app

[ -f ~/.ssh/id_dsa ] || {
  ssh-keygen -q -b 1024 -t dsa -f ~/.ssh/id_dsa -N ""
}

