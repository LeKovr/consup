# consup_master
# Consup master image
# https://registry.hub.docker.com/u/lekovr/consup_master/

FROM lekovr/consup_base

ENV DOCKERFILE_VERSION  141116

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

# -------------------------------------------------------------------------------
# Install apt-cacher-ng

RUN apt-get install -y apt-cacher-ng

COPY supervisor.d/apt-cacher.conf /etc/supervisor/conf.d/
EXPOSE 3142

VOLUME /var/cache/apt-cacher-ng
COPY init.d /init.d

# -------------------------------------------------------------------------------
# Setup Consul server

COPY consul.d /etc/consul.d
COPY supervisor.d/consul-server.conf /etc/supervisor/conf.d/
EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53/udp

