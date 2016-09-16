#!/bin/bash

# Run command via uid of current user ($FLAG owner)
FLAG=/home/app/nodejs.yml

# Create user if none
if [[ "$APPUSER" ]]; then
  grep -qe "^$APPUSER:" /etc/passwd || useradd -m -r -s /bin/bash -Gwww-data -gusers -gsudo $APPUSER
fi

# Change user id to FLAG owner's uid
FLAG_UID=$(stat -c "%u" $FLAG)
if [[ "$FLAG_UID" ]] && [[ $FLAG_UID != $(id -u $APPUSER) ]]; then
  echo "Set uid $FLAG_UID for user $APPUSER"
  usermod -u $FLAG_UID $APPUSER
  chown -R $APPUSER /home/op
fi

export PATH=/usr/lib/node_modules/.bin:$PATH
export NODE_PATH=/usr/lib/node_modules
echo "Run main shell.."
gosu $APPUSER $@
