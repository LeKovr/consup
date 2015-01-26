# consup_baseapp
# Consup base app image
#

FROM lekovr/consup_base

ENV DOCKERFILE_VERSION  141116

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

# -------------------------------------------------------------------------------
# Setup Consul client

COPY supervisor.d   /etc/supervisor/conf.d
COPY consul.d /etc/consul.d
COPY init.d   /init.d

# -------------------------------------------------------------------------------
# Setup proxy to apt-cacher-ng

ADD deb-proxy-discover /usr/local/bin/deb-proxy-discover
RUN chmod +x /usr/local/bin/deb-proxy-discover && \
  echo "Acquire::http::ProxyAutoDetect \"/usr/local/bin/deb-proxy-discover\";" > /etc/apt/apt.conf.d/30autoproxy

# -------------------------------------------------------------------------------
# Add repo for pg-9.3 in wheezy

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
  && wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add - \
  && apt-get update
