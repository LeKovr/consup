# consup_nginx
# Consup nginx image
#

FROM lekovr/consup_baseapp

ENV DOCKERFILE_VERSION  150622

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>


# -------------------------------------------------------------------------------
# Install nginx

# RUN apt-get -y install nginx-extras

# Based on https://github.com/nginxinc/docker-nginx
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" >> /etc/apt/sources.list

ENV NGINX_VERSION 1.9.3-1~wheezy

RUN apt-get update && \
    apt-get install -y ca-certificates nginx=${NGINX_VERSION} && \
    sed -i.bak \
      -e 's|access_log .*|access_log  off;|' \
      -e 's|error_log .*|error_log  /dev/stderr notice;|' \
      -e 's|$remote_addr|$http_x_real_ip|' \
      /etc/nginx/nginx.conf && \
    rm /etc/nginx/conf.d/default.conf

# TODO: remove after checking realip via proxy
#      -e 's| "$http_x_forwarded_for"||' \

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

COPY init.d /init.d
COPY consul /etc/consul
COPY supervisor.d /etc/supervisor/conf.d

ADD fastcgi_params /etc/nginx/
ADD proxy_params /etc/nginx/

# ------------------------------------------------------------
# Frontend server config

# Consul upstreams domain for service named "web"
ENV CONSUL_DOMAIN web.service.consul

# Redirect 502 errors
ENV DEFAULT_SITE http://localhost

# Use frontend config in this MODE
# (see init.d/setup_nginx.sh)
ENV FRONT_MODE common

# Use redirect config in this MODE
# (see init.d/setup_nginx.sh)
ENV REDIR_MODE redir

# Register this service in consul
ENV SERVICE webfront

# ------------------------------------------------------------
# Backend server config (FRONT_MODE != common, SERVICE == web)

# Site hostname
ENV PROJECT demo.dev.lan

# Document root = /home/www/$HTML_DIR
ENV HTML_DIR html

# Document root will be under this dir
VOLUME ["/home/www"]
