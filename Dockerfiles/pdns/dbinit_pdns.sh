#!/bin/bash

# strict mode http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

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
curl -s "http://$PG_HOST:$DBCC_PORT/?key=$DBCC_KEY&name=$DB_NAME&pass=$DB_PASS" | grep "OK: 1" && {
  log "Created database $DB_NAME"
  # Init db if needed

  log "Create tables"
  PGPASSWORD=$DB_PASS psql -X -h $PG_HOST -U $DB_NAME -f /usr/share/dbconfig-common/data/pdns-backend-pgsql/install/pgsql

  log "Load local data if any"
  DIR=/home/app
  for f in domains records domainmetadata ; do
    [ -f $DIR/$f.txt ] && log $f && PGPASSWORD=$DB_PASS psql -X -h $PG_HOST -U $DB_NAME -c "\copy $f from $DIR/$f.txt"
  done

}
log "db ready"

# Setup pdns in every start in case of vars change

F=/etc/dbconfig-common/pdns-backend-pgsql.conf

sed -i.orig -e "s|dbc_dbserver=''|dbc_dbserver='$PG_HOST'|" \
  -e "s|dbc_dbname='pdns'|dbc_dbname='$DB_NAME'|" \
  -e "s|dbc_dbuser='pdns'|dbc_dbuser='$DB_NAME'|" \
  -e "s|dbc_dbpass='.*'|dbc_dbpass='$DB_PASS'|" \
  $F

dpkg-reconfigure pdns-backend-pgsql

# change port to $PDNS_PORT
sed -ri "s/# local-port=53/local-port=$PDNS_PORT/" /etc/powerdns/pdns.conf

# listen only container ip
net=$(ip a | grep global | cut -d " " -f6)
ip=${net%/*}
sed -ri "s/# local-address=0.0.0.0/local-address=$ip/" /etc/powerdns/pdns.conf

# start pdns
log "Start app"
supervisorctl -c /etc/supervisor/supervisord.conf start pdns

log "Done"
# Say all is Ok to supervisor
exit 0
