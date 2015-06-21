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

# Consul upstreams domain for service named "web"
ENV CONSUL_DOMAIN web.service.consul

# Redirect 502 errors
ENV DEFAULT_SITE http://localhost

# Run nginx frontend in this MODE
ENV FRONT_MODE common

# Register this service in consul
ENV SERVICE webfront
