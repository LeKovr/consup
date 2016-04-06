
# change directory perms if host storage attached

if [ ! -d "$PGDATA" ]; then
  mkdir -p -m 0700 "$PGDATA"
  chown -R $PGUSER:$PGUSER "$PGDATA"
fi

if [[ "$REPLICA_MODE" != "AIR" ]] ; then
  # Setup PGDATA on mounted volume

  if [ -z "$(ls -A "$PGDATA")" ]; then
    # PGDATA is empty, copy new cluster from .eta
    cp -dpr /var/lib/postgresql.eta/* $PGDATA
  else
    # PGDATA already exists, change container's user postgres UIG & GID to fit PGDATA
    DIR_UID=$(stat -c "%u" $PGDATA)
    if [[ "$DIR_UID" ]] && [[ $DIR_UID != $(id -u $PGUSER) ]]; then
      usermod -u $DIR_UID $PGUSER
    fi

    DIR_GID=$(stat -c "%g" $PGDATA)
    if [[ "$DIR_GID" ]] && [[ $DIR_GID != $(id -g $PGUSER) ]]; then
      groupmod -g $DIR_GID $PGUSER
    fi
    chown -R $DIR_UID:$DIR_GID /var/run/postgresql
  fi
fi

echo "REPLICA: $REPLICA_MODE"

[ -d $REPLICA_ROOT ] || mkdir -p $REPLICA_ROOT

if [[ "$REPLICA_MODE" == "MASTER" ]] || [[ "$REPLICA_MODE" == "SLAVE" ]] ; then
  grep "** REPLICA CONF **" $PGDATA/postgresql.conf > /dev/null || cat >> $PGDATA/postgresql.conf  <<EOF
  # ** REPLICA CONF **
  checkpoint_segments = 8
  wal_keep_segments = 8
  archive_command = 'test ! -f $REPLICA_ROOT/%f.gz && gzip < %p > $REPLICA_ROOT/%f.gz && chmod a+r $REPLICA_ROOT/%f.gz'
  archive_timeout = 60
EOF

#  archive_command = 'cp -f %p $REPLICA_ROOT/%f </dev/null '

  if [[ "$REPLICA_MODE" == "MASTER" ]] ; then
    chown -R $DIR_UID:$DIR_GID $REPLICA_ROOT
    grep "# CONSUPMASTER" $PGDATA/postgresql.conf > /dev/null || cat >> $PGDATA/postgresql.conf  <<EOF
  wal_level = hot_standby   # CONSUPMASTER_wal
  max_wal_senders = 3       # CONSUPMASTER_max
  archive_mode = on         # CONSUPMASTER_mode
EOF
    grep "** MASTER CONF **" $PGDATA/pg_hba.conf > /dev/null || cat >> $PGDATA/pg_hba.conf  <<EOF
  # ** MASTER CONF **
  local   replication     postgres                                trust
EOF
  else #if [[ "$REPLICA_MODE" == "SLAVE" ]] ; then
    [ -f $REPLICA_ROOT/base.tar.gz ] && [ ! -f $PGDATA/imported ] && {
      echo "Loading database.tar.gz..."
      rm -rf $PGDATA/*
      tar -zxf $REPLICA_ROOT/base.tar.gz -C $PGDATA
      grep -v "# CONSUPMASTER" $PGDATA/postgresql.conf > $PGDATA/postgresql.conf.tmp
      mv $PGDATA/postgresql.conf.tmp $PGDATA/postgresql.conf
      touch $PGDATA/imported
    }

    grep "# CONSUPSLAVE" $PGDATA/postgresql.conf > /dev/null || cat >> $PGDATA/postgresql.conf  <<EOF
  hot_standby = on   # CONSUPSLAVE_hot
EOF
    [ -f $PGDATA/recovery.conf ] || cat >> $PGDATA/recovery.conf <<EOF
  restore_command = 'gunzip < $REPLICA_ROOT/%f.gz > %p'
  standby_mode = 'on'
  trigger_file = '$PGDATA/replica.master'
EOF
#  restore_command = 'pg_standby $REPLICA_ROOT %f %p %r'
#  primary_conninfo = 'host=127.0.0.1'

  fi

elif [[ "$REPLICA_MODE" == "AIR" ]] ; then
  # use .eta as PGDATA
  export PGDATA=/var/lib/postgresql.eta/$PG_MAJOR
fi
