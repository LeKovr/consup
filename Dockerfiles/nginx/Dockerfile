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

ENV NGINX_VERSION 1.9.2-1~wheezy

RUN apt-get update && \
    apt-get install -y ca-certificates nginx=${NGINX_VERSION}

RUN rm /etc/nginx/conf.d/default.conf

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

# access log only, errors go to supervisor
VOLUME ["/var/log/nginx"]

COPY init.d /init.d
COPY consul /etc/consul
COPY supervisor.d /etc/supervisor/conf.d

ADD *_params /etc/nginx/

# Consul upstreams domain for service named "web"
ENV CONSUL_DOMAIN web.service.consul

# Redirect 502 errors
ENV DEFAULT_SITE http://localhost

# Run nginx frontend in this MODE
ENV FRONT_MODE common

# Register this service in consul
ENV SERVICE webfront
