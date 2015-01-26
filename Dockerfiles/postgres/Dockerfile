# consup_postgres
# Consup based Postgresql image
#

FROM lekovr/consup_baseapp

ENV DOCKERFILE_VERSION  141116

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

# -------------------------------------------------------------------------------
# Install postgresql

ENV PG_MAJOR 9.3

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r postgres && useradd -r -g postgres postgres

RUN apt-get install -y postgresql-common \
 && sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf \
 && apt-get install -y \
  postgresql-contrib-$PG_MAJOR \
  postgresql-plperl-$PG_MAJOR

# -------------------------------------------------------------------------------
# Install check_postgres

RUN CHKPG_VER=2.21.0 && curl -OL http://bucardo.org/downloads/check_postgres-${CHKPG_VER}.tar.gz \
  && tar -zxf check_postgres-${CHKPG_VER}.tar.gz \
  && mv check_postgres-${CHKPG_VER}/check_postgres.pl /usr/local/bin/ \
  && rm check_postgres-${CHKPG_VER}.tar.gz \
  && rm -rf check_postgres-${CHKPG_VER}

# -------------------------------------------------------------------------------
# Setup Consul client

COPY consul.d /etc/consul.d
COPY init.d /init.d
COPY supervisor.d /etc/supervisor/conf.d

ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/$PG_MAJOR

RUN gosu postgres initdb \
  && sed -ri "s/^#(listen_addresses\s*=\s*)\S+/\1'*'/" $PGDATA/postgresql.conf \
  && echo "host  all all 172.17.0.0/16 md5" >> $PGDATA/pg_hba.conf \
  && mv $PGDATA /var/lib/postgresql.eta

VOLUME ["/var/lib/postgresql"]

EXPOSE 5432

