
# -------------------------------------------------------------------------------
# Install postgresql server

apt-get update && apt-get install -y postgresql-common \
 && sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf \
 && apt-get install -y \
  postgresql-contrib-$PG_MAJOR \
  postgresql-plperl-$PG_MAJOR
