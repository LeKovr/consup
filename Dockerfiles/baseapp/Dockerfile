# consup_baseapp
# Consup base app image
#

FROM lekovr/consup_base

ENV DOCKERFILE_VERSION  150130

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

# -------------------------------------------------------------------------------
# Setup Consul client

COPY supervisor.d   /etc/supervisor/conf.d
COPY consul         /etc/consul
COPY init.d         /init.d

# consul server's ip or hostname
ENV CONSUL_MASTER consul

# consul resolver
ENV DNS_MASTER    8.8.8.8

# -------------------------------------------------------------------------------
# Add repo for pg-9.3 in wheezy
# & update package list

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
  && wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add - \
  && apt-get update
