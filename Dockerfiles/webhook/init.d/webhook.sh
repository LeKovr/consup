
# Setup webhook user id

set -e

# Create docker group
if ! grep -q "^${group}:" /etc/group ; then
  groupadd docker
fi

# Set docker group id like docker.sock owner
groupmod -g $(stat -c "%g" /var/run/docker.sock) docker

# Add user to group docker
usermod -g docker $APPUSER


