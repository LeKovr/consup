#!/bin/bash

# Wait for postgres and start dependent services
log() {
  D=$(date "+%F %T")
  echo  "$D $1"
}

# Check when DB begins accept connections & reload consul after
log "Wait for PG"
while ! gosu postgres check_postgres.pl --action connection >/dev/null ; do
sleep 1
done
#echo "PG ready. Start Consul"
#supervisorctl -c /etc/supervisor/supervisord.conf start consul

log "Slow check"
# Change healh check interval
sed -i '/"interval": "1s"/c       "interval": "1m"' /etc/consul/src/postgres.json
consul reload

log "Start dbcc"
supervisorctl -c /etc/supervisor/supervisord.conf start dbcc

log "Done"
# Say all is Ok to supervisor
exit 0
