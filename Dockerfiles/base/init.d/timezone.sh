
# Setup timezone from ENV{TZ} if set

if [[ "$TZ" ]] && [ -f /usr/share/zoneinfo/$TZ ]; then
  echo $TZ > /etc/timezone
  cp /usr/share/zoneinfo/$TZ /etc/localtime
fi

