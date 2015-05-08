
# Create postgresql database

gosu postgres initdb \
  && sed -ri "s/^#(listen_addresses\s*=\s*)\S+/\1'*'/" $PGDATA/postgresql.conf \
  && echo "host  all all 172.17.0.0/16 md5" >> $PGDATA/pg_hba.conf \
  && mv $PGDATA /var/lib/postgresql.eta
