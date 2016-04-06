
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

#Setup replication
echo "** Replication: $REPLICA_MODE"

[ -d $REPLICA_ROOT ] || mkdir -p $REPLICA_ROOT && chown -R $DIR_UID:$DIR_GID $REPLICA_ROOT

if [[ "$REPLICA_MODE" == "MASTER" ]] || [[ "$REPLICA_MODE" == "SLAVE" ]] ; then

  [ -f $PGDATA/replica.conf ] && rm $PGDATA/replica.conf

  if [[ "$REPLICA_MODE" == "MASTER" ]] ; then
    cp /etc/postgresql/replica_master.conf $PGDATA/replica.conf
  else #if [[ "$REPLICA_MODE" == "SLAVE" ]] ; then
    [ -f $REPLICA_ROOT/base.tar.gz ] && [ ! -f $PGDATA/imported ] && {
      echo "Loading database.tar.gz..."
      rm -rf $PGDATA/*
      tar -zxf $REPLICA_ROOT/base.tar.gz -C $PGDATA
      touch $PGDATA/imported
    }

    cp /etc/postgresql/replica_slave.conf $PGDATA/replica.conf
    [ -f $PGDATA/recovery.conf ] || cp /etc/postgresql/replica_recovery.conf $PGDATA/recovery.conf

  fi

elif [[ "$REPLICA_MODE" == "AIR" ]] ; then
  # use .eta as PGDATA
  export PGDATA=/var/lib/postgresql.eta/$PG_MAJOR
fi
