# consup_webhook
# Consup webhook image
# See https://github.com/LeKovr/consup
#

FROM lekovr/consup_nginx

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

ENV DOCKERFILE_VERSION  160320

# -------------------------------------------------------------------------------
# Run custom setup scripts

ADD setup_*.sh /tmp/
RUN for f in /tmp/setup_*.sh ; do >&2 echo ">>>> $f" ; . $f ; rm $f ; done

# -------------------------------------------------------------------------------
# App staff

COPY init.d /init.d

ENV APP_PORT 9000

# -------------------------------------------------------------------------------
# Docker

# hook user
ENV APPUSER op

# Docker control
VOLUME /var/run/docker.sock

# Distro root
ENV DISTRO_DIR /home/app/distros

# -------------------------------------------------------------------------------
# Setup Consup client

COPY supervisor.d /etc/supervisor/conf.d

WORKDIR /home/app

