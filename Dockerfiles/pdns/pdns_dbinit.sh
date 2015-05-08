#!/bin/bash


echo "***** RUN INIT $DB_NAME / $DB_PASS ***"

# time to start local consul copy
sleep 1

# TODO: Alternative check of user & database existense
# PGPASSWORD=$DB_PASS psql -X -h $DB_HOST -U $DB_NAME -P tuples_only -c "SELECT NULL" > /dev/null && { echo "Database already exists" ; exit ; }

# Try to create user & database. Get result
curl -s "http://$DB_HOST:8080/?key=$DBCC_KEY&name=$DB_NAME&pass=$DB_PASS" | grep "OK: .1" && {

  echo "DB created right now, create tables"
  PGPASSWORD=$DB_PASS psql -X -h $DB_HOST -U $DB_NAME -f /usr/share/dbconfig-common/data/pdns-backend-pgsql/install/pgsql

  echo "Load local data if any"
  DIR=/var/lib/pdns
  for f in domains records domainmetadata ; do
    [ -f $DIR/$f.sql ] && PGPASSWORD=$DB_PASS psql -X -h $DB_HOST -U $DB_NAME -f $DIR/$f.sql
  done

}

# Setup pdns in every start in case of vars change

F=/etc/dbconfig-common/pdns-backend-pgsql.conf

sed -i.orig -e "s|dbc_dbserver=''|dbc_dbserver='$DB_HOST'|" \
  -e "s|dbc_dbname='pdns'|dbc_dbname='$DB_NAME'|" \
  -e "s|dbc_dbuser='pdns'|dbc_dbuser='$DB_NAME'|" \
  -e "s|dbc_dbpass='.*'|dbc_dbpass='$DB_PASS'|" \
  $F

dpkg-reconfigure pdns-backend-pgsql

# start pdns
supervisorctl -c /etc/supervisor/supervisord.conf start pdns

# Say all is Ok to supervisor
exit 0
