# consup_postgres
# Consup based Postgresql image
# See https://github.com/LeKovr/consup
#

FROM lekovr/consup_baseapp

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

ENV DOCKERFILE_VERSION  160320

# -------------------------------------------------------------------------------
# Install postgresql

ENV PG_MAJOR 9.3

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r postgres && useradd -r -g postgres -d /var/lib/postgresql postgres

ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/$PG_MAJOR

# -------------------------------------------------------------------------------
# Run custom setup scripts

ADD setup_*.sh /tmp/
RUN for f in /tmp/setup_*.sh ; do >&2 echo ">>>> $f" ; . $f ; rm $f ; done

# -------------------------------------------------------------------------------
# Setup Consul client

COPY consul /etc/consul
COPY init.d /init.d
COPY supervisor.d /etc/supervisor/conf.d

# -------------------------------------------------------------------------------

# db startup trigger
COPY db_check_started.sh /usr/local/bin/db_check_started.sh

# dbcc connect key
ENV DBCC_KEY SET_YOUR_DBCC_KEY_HERE_OR_IN_fidm.yml

# dbcc port
ENV DBCC_PORT 5480

# postgres & dbcc ports
EXPOSE 5432 5480

# this will be mounted externally
VOLUME ["/var/lib/postgresql"]

# Database locale
ENV LOCALE en_US

# Run master server
# See init.d/postgres.sh
# Other options are:
# ENV REPLICA_MODE MASTER
# ENV REPLICA_MODE SLAVE

ENV REPLICA_MODE ""
