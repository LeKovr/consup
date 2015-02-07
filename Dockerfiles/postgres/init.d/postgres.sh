
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
