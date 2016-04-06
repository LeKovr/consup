
# -------------------------------------------------------------------------------
# Install postgresql server

apt-get update && apt-get install -y postgresql-common \
 && sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf \
 && apt-get install -y \
  postgresql-contrib-$PG_MAJOR \
  postgresql-plperl-$PG_MAJOR

# -------------------------------------------------------------------------------
# Create postgresql database

gosu postgres initdb \
  && sed -ri "s/^#(listen_addresses\s*=\s*)\S+/\1'*'/" $PGDATA/postgresql.conf \
  && echo "include = 'replica.conf'" >> $PGDATA/postgresql.conf \
  && sed -ri "s/^#(local\s+replication\s+postgres\s+trust)/\1/" $PGDATA/pg_hba.conf \
  && echo "host  all all 172.17.0.0/16 md5" >> $PGDATA/pg_hba.conf \
  && touch $PGDATA/replica.conf \
  && mv $PGDATA /var/lib/postgresql.eta
