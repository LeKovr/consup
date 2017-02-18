#!/bin/bash
# ------------------------------------------------------------------------------
# Remote server init script
# This script called from local host for set up a fresh (cloud) server
# ------------------------------------------------------------------------------

# Target host name
hname=$1

[[ "$hname" ]] || {
  echo "  Usage:"
  echo "    rsm.sh HOST_IP"
  exit 1
}

# ------------------------------------------------------------------------------

[[ "$SSHKEY" ]] || SSHKEY=~/.ssh/id_dsa.pub
[[ "$SWAP" ]]   || SWAP=none
[[ "$ADMIN" ]]  || ADMIN=op

cat <<EOF
  VDS $hname setup:
    ssh key:    $SSHKEY
    swap size:  $SWAP
    admin user: $ADMIN

  You should edit ~/.ssh/config if need handy host name
EOF
read -p "[Hit Enter to continue]" X

# ------------------------------------------------------------------------------

echo "** Copy ssh pub key..."
ssh-copy-id -i $SSHKEY root@$hname

# ------------------------------------------------------------------------------

echo "** Run remote setup..."
ssh root@$hname 'bash -s' << EOF

# stop on error
set -e

# ------------------------------------------------------------------------------
# https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04

swap_file=/swapfile
if [[ "$SWAP" != "none" ]] && [ ! -f \$swap_file ] ; then
  echo "*** Enable swap"
  fallocate -l $SWAP \$swap_file
  chmod 600 \$swap_file
  mkswap \$swap_file
  swapon \$swap_file
  echo "\$Sswap_file   none    swap    sw    0   0" >> /etc/fstab
fi

# ------------------------------------------------------------------------------
echo "*** Tune server"
grep vm.swappiness /etc/sysctl.conf || {
  echo "vm.swappiness=10" >> /etc/sysctl.conf
  sysctl vm.swappiness=10
}

grep vfs_cache_pressure /etc/sysctl.conf || {
  echo "vfs_cache_pressure=50" >> /etc/sysctl.conf
  sysctl vm.vfs_cache_pressure=50
}

# ------------------------------------------------------------------------------
echo "*** Setup locale"
locale-gen $LC_NAME

# ------------------------------------------------------------------------------
[ -f /etc/cron.daily/ntpdate ] || {
  echo "ntpdate -u ntp.ubuntu.com pool.ntp.org" > /etc/cron.daily/ntpdate
  chmod a+x /etc/cron.daily/ntpdate
}

# ------------------------------------------------------------------------------

DEBIAN_FRONTEND=noninteractive

echo "*** Install docker"
which docker > /dev/null || wget -qO- https://get.docker.com/ | sh

echo "*** Update packages"
apt-get -y remove apache2 python-samba samba-common
apt-get -y install mc wget make sudo ntpdate

#apt-get update
#apt-get -y upgrade
# apt-get install -y linux-generic linux-headers-generic linux-image-generic

# ------------------------------------------------------------------------------
if [[ "$ADMIN" != "none" ]] ; then
  echo "*** Create user $ADMIN"
  NEWUSER=$ADMIN
  HOMEROOT=/home
  HOMEDIR=\$HOMEROOT/\$NEWUSER
  [ -d \$HOMEROOT ] || mkdir \$HOMEROOT

  # Check if user exists already
  grep -qe "^\$NEWUSER:" /etc/passwd || useradd -d \$HOMEDIR -m -r -s /bin/bash -Gwww-data -gusers -gdocker \$NEWUSER
  [ -d \$HOMEDIR/.ssh ] || sudo -u \$NEWUSER mkdir -m 700 \$HOMEDIR/.ssh

  KEYFILE=\$HOMEDIR/.ssh/authorized_keys
  if [ ! -f \$KEYFILE ] ; then
    cp /root/.ssh/authorized_keys \$KEYFILE
    chown \$NEWUSER \$KEYFILE
    chmod 600 \$KEYFILE
  fi

  # allow sudo without pass
  [ -f /etc/sudoers.d/\$NEWUSER ] || {
    echo "\$NEWUSER ALL=NOPASSWD:ALL" > /etc/sudoers.d/\$NEWUSER
    chmod 440 /etc/sudoers.d/\$NEWUSER
  }

fi

# ------------------------------------------------------------------------------
## UFW on
#ufw allow OpenSSH
#echo 'y' | ufw enable

# ------------------------------------------------------------------------------
echo "*** Setup ssh"

# Deny root login via ssh
sed -i "/^PermitRootLogin.*/c PermitRootLogin no" /etc/ssh/sshd_config

# Deny password login
sed -i "/#PasswordAuthentication *yes/c PasswordAuthentication no" /etc/ssh/sshd_config

service ssh reload

EOF

# ------------------------------------------------------------------------------
echo "** Server setup complete"
