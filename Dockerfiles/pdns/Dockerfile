# consup_powerdns
# Consup powerdns DNS server image
# See https://github.com/LeKovr/consup
#

FROM lekovr/consup_baseapp

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

ENV DOCKERFILE_VERSION  150429

# -------------------------------------------------------------------------------
# Install PG client

RUN apt-get -y install \
    postgresql-client \
    pdns-backend-pgsql && \
    rm -f /etc/powerdns/pdns.d/pdns.simplebind && \
    sed -ri "s/local-port=53/local-port=54/" /etc/powerdns/pdns.conf
# -------------------------------------------------------------------------------
# Setup Consup client

COPY consul /etc/consul
COPY supervisor.d /etc/supervisor/conf.d
COPY pdns_dbinit.sh /usr/local/bin/

EXPOSE 54 54/udp


# pdns database host
ENV DB_HOST common.db.service.consul
ENV DB_NAME pdns
ENV DB_PASS SET_DB_PASS_HERE_OR_IN_fidm.yml

# key to create db via dbcc service
ENV DBCC_KEY SET_DBCC_KEY_HERE_OR_IN_fidm.yml

