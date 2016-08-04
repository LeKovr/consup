#!/bin/bash
# Wait postgresql startup, create database if needed & start app

# strict mode http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# logging func
log() {
  D=$(date "+%F %T")
  echo  "$D $1"
}

# onExit handler
function finish {
  # Special formatted message, do not change
  log "** Init done **"
}
trap finish EXIT

# ------------------------------------------------------------------------------

log "***** RUN INIT FOR DB $DB_NAME ***"

log "Wait for consul and postgresql startup..."
while true; do sleep 1 && ping -c1 $PG_HOST > /dev/null 2>&1 && break; done
log "DB started"

# Try to create user & database. Get result
log "Check db"
if [ "$DB_TEMPLATE" ] ; then
  tmpl="&tmpl=$DB_TEMPLATE"
  note=" with template $DB_TEMPLATE"
else
  tmpl=""
  note=""
fi

curl -s "http://$PG_HOST:$DBCC_PORT/?key=$DBCC_KEY&name=$DB_NAME&pass=$DB_PASS$tmpl" | grep "OK: 1" && {
  log "Created database $DB_NAME$note"
  if [ -e /home/app/.ondbcreate ] ; then
    log "Run onDBCreate script"
    . /home/app/.ondbcreate
  fi
}

log "Start app"
supervisorctl -c /etc/supervisor/supervisord.conf start pgrest
supervisorctl -c /etc/supervisor/supervisord.conf start dbrpc

if [ -e /home/app/.ondbready ] ; then
  log "Run onDBReady script"
  . /home/app/.ondbready
fi

# Say all is Ok to supervisor
exit 0
