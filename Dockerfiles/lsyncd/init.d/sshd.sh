
# Setup container sshd

[ -d /var/run/sshd ] || mkdir -p /var/run/sshd

DEST=/etc/ssh/sshd_config

# Deny root login via ssh
sed -i "/^PermitRootLogin.*/c PermitRootLogin no" $DEST

# Deny password login
sed -i "/^PasswordAuthentication *yes/c PasswordAuthentication no" $DEST

# Allow supervisor logs
sed -i "/^StrictModes yes/c StrictModes no" $DEST

# Change sshd port if it !=22
if [[ "$SSHD_PORT" != "22" ]] ; then
  sed -i "/Port 22/c Port $SSHD_PORT" $DEST
fi

# TODO: set this option in lsyncd config
echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
