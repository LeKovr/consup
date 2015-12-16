# consup_postgres
# Consup based Postgresql image
#

FROM lekovr/consup_baseapp

ENV DOCKERFILE_VERSION  150130

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

# -------------------------------------------------------------------------------
# Install postgresql

ENV PG_MAJOR 9.3

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r postgres && useradd -r -g postgres -d /var/lib/postgresql postgres

RUN apt-get update && apt-get install -y postgresql-common \
 && sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf \
 && apt-get install -y \
  postgresql-contrib-$PG_MAJOR \
  postgresql-plperl-$PG_MAJOR

ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/$PG_MAJOR

# -------------------------------------------------------------------------------
# Run custom setup scripts

COPY . /tmp/consup-build/
RUN for f in /tmp/consup-build/setup_*.sh ; do echo $f ; . $f ; done && rm -rf /tmp/consup-build

# -------------------------------------------------------------------------------
# Setup Consul client

COPY consul /etc/consul
COPY init.d /init.d
COPY supervisor.d /etc/supervisor/conf.d

# -------------------------------------------------------------------------------

# db startup trigger
COPY db_check_started.sh /usr/local/bin/db_check_started.sh

# consul started by db_check_started.sh
#RUN echo "autostart=false" >> /etc/supervisor/conf.d/consul.conf

# dbcc connect key
ENV DBCC_KEY SET_YOUR_DBCC_KEY_HERE_OR_IN_fidm.yml
# dbcc port
ENV DBCC_PORT 5480

# postgres & dbcc ports
EXPOSE 5432 5480

# this will be mounted externally
VOLUME ["/var/lib/postgresql"]
