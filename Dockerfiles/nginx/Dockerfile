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

COPY consul.d /etc/consul.d
COPY conf.d /etc/supervisor/conf.d

