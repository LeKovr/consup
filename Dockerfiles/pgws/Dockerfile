# consup_pgws
# Consup PGWS image
#

FROM consup_nginx

ENV DOCKERFILE_VERSION  141116

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

# -------------------------------------------------------------------------------
# Install PG client

RUN apt-get -y install \
    postgresql-client

# -------------------------------------------------------------------------------
# PGWS staff

COPY setup_*.sh /opt/
RUN for f in /opt/setup_*.sh ; do . $f ; done && rm /opt/setup_*.sh

# -------------------------------------------------------------------------------
# Setup Consup client

COPY init.d /init.d

WORKDIR /home/app
