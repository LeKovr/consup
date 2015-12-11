
# Create user & his home dir

home=/home/app/$APPUSER

# Check if user exists already
# grep -qe "^$APPUSER:" /etc/passwd || useradd -m -r -s /bin/bash -Gwww-data -gusers -gsudo $APPUSER
grep -qe "^$APPUSER:" /etc/passwd || useradd -d $home $APPUSER

# DEST Used by gogs install
# This will be removed after switch to consul-template >= 0.11.1
DEST=/opt/gogs/custom/conf
chown -R $APPUSER $DEST

# Mount point owner
chown $APPUSER /home/app
