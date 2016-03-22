# consup_gogs
# Consup gogs image
# See https://github.com/LeKovr/consup
#

FROM lekovr/consup_baseapp

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

ENV DOCKERFILE_VERSION  160320

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# -------------------------------------------------------------------------------
# Run custom setup scripts

ADD setup_*.sh /tmp/
RUN for f in /tmp/setup_*.sh ; do >&2 echo ">>>> $f" ; . $f ; rm $f ; done

# -------------------------------------------------------------------------------
# SSHD staff

ENV APPUSER rsync
ENV SSHD_PORT 72

# Port exposed by fidm or by hand
# EXPOSE 72

COPY init.d /init.d

# -------------------------------------------------------------------------------
# Setup Consup client

COPY consul /etc/consul
COPY supervisor.d /etc/supervisor/conf.d

WORKDIR /home/app

# ------------------------------------------------------------
# Backend server config

# Synced data
ENV SYNC_HOST

ENV SYNC_PATH /opt
VOLUME ["/opt"]
