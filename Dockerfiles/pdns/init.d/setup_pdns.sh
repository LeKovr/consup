#
# Setup pdns in every start in case of vars change
#

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

# add custom config if exists
[ -f /home/app/pdns.conf.add ] && cat /home/app/pdns.conf.add >> /etc/powerdns/pdns.conf || true
