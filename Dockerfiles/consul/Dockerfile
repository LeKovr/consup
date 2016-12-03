# consup_consul
# Consup consul image
# See https://github.com/LeKovr/consup
# https://registry.hub.docker.com/u/lekovr/consup_consul/

FROM lekovr/consup_base

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

ENV DOCKERFILE_VERSION  161203

# -------------------------------------------------------------------------------
# Setup Consul server

COPY consul /etc/consul

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53 53/udp

# consul resolver
ENV DNS_MASTER 8.8.8.8

VOLUME ["/var/lib/consul"]

CMD ["/init.d.sh", "/usr/local/bin/consul", "agent", "-config-dir=/etc/consul/conf.d" ]
