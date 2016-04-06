#!/bin/bash

# Wait for postgres and start dependent services
log() {
  D=$(date "+%F %T")
  echo  "$D $1"
}

# Check when DB begins accept connections & reload consul after
log "Wait for PG"
while ! gosu postgres pg_isready -q ; do
  sleep 1
done

#log "Raise check interval"
# Change health check interval
#sed -i '/"interval": "1s"/c       "interval": "1m"' /etc/consul/src/postgres.json && \
#  sleep 1 && consul reload

log "Start dbcc"
supervisorctl -c /etc/supervisor/supervisord.conf start dbcc

echo "PG ready. Start Consul"
supervisorctl -c /etc/supervisor/supervisord.conf start consul

# Fast reload done, raise check interval
sleep 1 && consul reload

if [[ "$REPLICA_MODE" == "MASTER" ]] ; then

  [ -f $REPLICA_ROOT/base.tar.gz ] || {
    log "Making base dump..."
    gosu postgres pg_basebackup -D $REPLICA_ROOT -Ft -z -x
  }
fi

log "Done"
# Say all is Ok to supervisor
exit 0
