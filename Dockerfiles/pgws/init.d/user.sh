
if [[ "$APPUSER" ]]; then

  # Check if user exists already
  grep -qe "^$APPUSER:" /etc/passwd || useradd -m -r -s /bin/bash -Gwww-data -gusers -gsudo $APPUSER

fi
