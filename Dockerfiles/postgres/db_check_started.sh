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

log "Start dbcc"
supervisorctl -c /etc/supervisor/supervisord.conf start dbcc

echo "PG ready. Start Consul"
# started manually because dbcc must be ready before activation
supervisorctl -c /etc/supervisor/supervisord.conf start consul

# Fast reload done, raise check interval
# (health ckeck started with 1sec for quick postgres activation)
sed -i -e 's|"interval": "1s"|"interval": "1m"|' /etc/consul/conf.d/postgres.json \
  && consul reload

if [[ "$REPLICA_MODE" == "MASTER" ]] && [ ! -f $REPLICA_ROOT/base.tar.gz ] ; then
  log "Making base dump..."
  gosu postgres pg_basebackup -D $REPLICA_ROOT/db -Ft -z -x \
  && mv $REPLICA_ROOT/db/db/base.tar.gz $REPLICA_ROOT/db \
  && rm $REPLICA_ROOT/db/db
fi

log "Done"
# Say all is Ok to supervisor
exit 0
