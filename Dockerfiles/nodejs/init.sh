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
    usermod -u $FLAG_UID $APPUSER
fi

echo "Run main shell.."
gosu $APPUSER $@
