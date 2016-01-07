# consup_gogs
# Consup gogs image
#

FROM lekovr/consup_baseapp

ENV DOCKERFILE_VERSION  160107

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# -------------------------------------------------------------------------------
# Install PG client

RUN apt-get update && apt-get -y upgrade && apt-get -y install \
    openssh-server rsync

# -------------------------------------------------------------------------------
# SSHD staff

ENV APPUSER rsync
ENV SSHD_PORT 72

# Port exposed by fidm or by hand
# EXPOSE 72

COPY init.d /init.d

# -------------------------------------------------------------------------------
# App staff

# Setup app
COPY setup_app.sh /tmp/consup-build/
RUN for f in /tmp/consup-build/setup_*.sh ; do echo $f ;  . $f ; done && rm -rf /tmp/consup-build

# -------------------------------------------------------------------------------
# Setup Consup client

COPY consul /etc/consul
COPY supervisor.d /etc/supervisor/conf.d

WORKDIR /home/app

# ------------------------------------------------------------
# Backend server config

# Synced data
VOLUME ["/opt"]
