# consup_nginx
# Consup nginx image
#

FROM lekovr/consup_baseapp

ENV DOCKERFILE_VERSION  141116

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>


# -------------------------------------------------------------------------------
# Install nginx

RUN apt-get -y install nginx-extras

RUN rm /etc/nginx/sites-enabled/default \
  && echo "daemon off;" >> /etc/nginx/nginx.conf \
  && echo "error_log /dev/stderr info;" >> /etc/nginx/nginx.conf

EXPOSE 80

# access log only, errors go to supervisor
VOLUME ["/var/log/nginx"]

COPY init.d /init.d
COPY consul /etc/consul
COPY supervisor.d /etc/supervisor/conf.d

# Common (public) domain
ENV WWW_DOMAIN devel.my

# Consul upstreams domain
ENV CONSUL_DOMAIN service.consul

# Run nginx proxy in this MODE
ENV FRONT_MODE common
