
# Setup webhook user id

set -e

group=docker

# Create docker group
if ! grep -q "^${group}:" /etc/group ; then
  groupadd $group
fi

# Set docker group id like docker.sock owner
groupmod -g $(stat -c "%g" /var/run/docker.sock) $group

# Add user to group docker
usermod -g $group $APPUSER

# create user's distro root
dr=/home/app/$DISTRO_ROOT
[ -d $dr ] || {
 mkdir $dr
 chown $APPUSER $dr
}


chown $APPUSER $SSH_KEY_NAME
chown $APPUSER ${SSH_KEY_NAME}.pub

