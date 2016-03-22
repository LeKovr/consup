
# Setup timezone from ENV{TZ} if set

if [[ "$TZ" ]] ; then
  if [ -f /usr/share/zoneinfo/$TZ ]; then
    echo $TZ > /etc/timezone
    cp /usr/share/zoneinfo/$TZ /etc/localtime
  else
    echo "WARNING: Unknown timezone ($TZ)"
  fi
fi
