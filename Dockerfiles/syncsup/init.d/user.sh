
# Create user & his home dir

home=/home/$APPUSER

# Check if user exists already
# grep -qe "^$APPUSER:" /etc/passwd || useradd -m -r -s /bin/bash -Gwww-data -gusers -gsudo $APPUSER
grep -qe "^$APPUSER:" /etc/passwd || useradd -d $home $APPUSER

chown $APPUSER /home/$APPUSER

