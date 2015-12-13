# consup_webhook
# Consup webhook image


FROM lekovr/consup_nginx

ENV DOCKERFILE_VERSION  151213

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# -------------------------------------------------------------------------------
# Install PG client

RUN apt-get update && apt-get -y upgrade && apt-get -y install \
    git make

# -------------------------------------------------------------------------------
# App staff

COPY init.d /init.d

# Setup app
COPY setup_app.sh /tmp/consup-build/
RUN for f in /tmp/consup-build/setup_*.sh ; do echo $f ;  . $f ; done && rm -rf /tmp/consup-build

ENV APP_PORT 9000

# -------------------------------------------------------------------------------
# Setup Consup client

COPY supervisor.d /etc/supervisor/conf.d

WORKDIR /home/app

# ------------------------------------------------------------
# Backend server config

