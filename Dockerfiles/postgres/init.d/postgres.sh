# This script runned on container start
# is will create database cluster (if none)
# and setup replication according to $REPLICA_MODE

# -------------------------------------------------------------------------------
# Create postgresql database cluster

dbinit() {
  gosu postgres initdb \
  && sed -ri "s/^#(listen_addresses\s*=\s*)\S+/\1'*'/" $PGDATA/postgresql.conf \
  && echo "include_if_exists = 'replica.conf'" >> $PGDATA/postgresql.conf \
  && echo "include_if_exists = 'pg_stat.conf'" >> $PGDATA/postgresql.conf \
  && sed -ri "s/^#(local\s+replication\s+postgres\s+trust)/\1/" $PGDATA/pg_hba.conf \
  && echo "host  all all 172.17.0.0/16 md5" >> $PGDATA/pg_hba.conf \
  && touch $PGDATA/replica.conf \
  && mv /etc/postgresql/pg_stat.conf $PGDATA \
  && echo "Database cluster created"

}

# -------------------------------------------------------------------------------

# change directory perms if host storage attached

if [ ! -d "$PGDATA" ]; then
  mkdir -p -m 0700 "$PGDATA"
  chown -R $PGUSER:$PGUSER "$PGDATA"
fi

# Setup PGDATA

if [ -z "$(ls -A "$PGDATA")" ]; then
  # PGDATA is empty, create new cluster
  dbinit
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

#Setup replication
echo "** Replication mode: $REPLICA_MODE"

[ -d $REPLICA_ROOT ] || { mkdir -p $REPLICA_ROOT ; chown -R $DIR_UID:$DIR_GID $REPLICA_ROOT ; }

if [[ "$REPLICA_MODE" == "MASTER" ]] || [[ "$REPLICA_MODE" == "SLAVE" ]] ; then

  [ -f $PGDATA/replica.conf ] && rm $PGDATA/replica.conf

  if [[ "$REPLICA_MODE" == "MASTER" ]] ; then
    [ -f $PGDATA/replica_master.conf ] || cp /etc/postgresql/replica_master.conf $PGDATA/
    ln -s replica_master.conf $PGDATA/replica.conf
  else #if [[ "$REPLICA_MODE" == "SLAVE" ]] ; then
    [ -f $REPLICA_ROOT/base.tar.gz ] && [ ! -f $PGDATA/imported ] && {
      echo "Loading database.tar.gz..."
      rm -rf $PGDATA/*
      tar -zxf $REPLICA_ROOT/base.tar.gz -C $PGDATA
      touch $PGDATA/imported
    }

    [ -f $PGDATA/replica_slave.conf ] || cp /etc/postgresql/replica_slave.conf $PGDATA/
    ln -s replica_slave.conf $PGDATA/replica.conf

    [ -f $PGDATA/recovery.conf ] || cp /etc/postgresql/replica_recovery.conf $PGDATA/recovery.conf

  fi
fi

# Setup tsearch if files exists
TSEARCH=/var/log/supervisor/pg-skel/tsearch_data
if [ -d $TSEARCH ] ; then
  cp -rf $TSEARCH /usr/share/postgresql/$PG_MAJOR
fi

echo "Postgresql setup complete"
