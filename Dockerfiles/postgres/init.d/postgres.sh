
# change directory perms if host storage attached

echo "***** RUN INIT ***"

U="postgres"
D="$PGDATA"

if [ ! -d "$PGDATA" ]; then
  mkdir -p -m 0700 "$PGDATA"
  chown -R $U:$U "$PGDATA"
fi

if [ -z "$(ls -A "$D")" ]; then
  # PGDATA is empty, copy new cluster from .eta
#  rm -rf /etc/postgresql/$PG_MAJOR/main
#  gosu $U pg_createcluster $PG_MAJOR main
  cp -dpr /var/lib/postgresql.eta/* $D
#  chown $U:$U "$PGDATA"
else
  # PGDATA already exists, change container's user postgres UIG & GID to fit PGDATA

  DIR_UID=$(stat -c "%u" $D)
  if [[ "$DIR_UID" ]] && [[ $DIR_UID != $(id -u $U) ]]; then
    usermod -u $DIR_UID $U
  fi

  DIR_GID=$(stat -c "%g" $D)
  if [[ "$DIR_GID" ]] && [[ $DIR_GID != $(id -g $U) ]]; then
    groupmod -g $DIR_GID $U
  fi
  chown -R $DIR_UID:$DIR_GID /var/run/postgresql
fi

repl_root=/shares/archive
[ -d $repl_root ] || mkdir -p $repl_root
if [[ "$REPLICA_MODE" == "MASTER" ]] ; then
  grep "** MASTER CONF **" $PGDATA/postgresql.conf > /dev/null || cat >> $PGDATA/postgresql.conf  <<EOF
  ** MASTER CONF **
  wal_level = hot_standby
  archive_mode = on
  archive_command = 'cp -f %p $repl_root/%f </dev/null '
EOF
  [ -f $repl_root/database.tar.gz ] || {
    echo "Making database.tar.gz..."
    make full copy
  }
elif [[ "$REPLICA_MODE" == "SLAVE" ]] ; then
  [ -f $PGDATA/recovery.conf ] || cat >> $PGDATA/recovery.conf <<EOF
restore_command = 'pg_standby $repl_root %f %p %r'
EOF
fi
