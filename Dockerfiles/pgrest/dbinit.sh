#!/bin/bash
# Wait postgresql startup, create database if needed & start app

log() {
  D=$(date "+%F %T")
  echo  "$D $1"
}

log "***** RUN INIT FOR DB $DB_NAME ***"

log "Wait for consul and postgresql startup..."
while true; do sleep 1 && ping -c1 $PG_HOST > /dev/null 2>&1 && break; done
log "DB started"

# Try to create user & database. Get result
log "Check db"
curl -s "http://$PG_HOST:$DBCC_PORT/?key=$DBCC_KEY&name=$DB_NAME&pass=$DB_PASS" | grep "OK: .1" && {
  log "Created database $DB_NAME"
}

log "Start app"
supervisorctl -c /etc/supervisor/supervisord.conf start pgrest

log "Done"
# Say all is Ok to supervisor
exit 0
