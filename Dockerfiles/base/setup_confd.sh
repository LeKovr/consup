
# -------------------------------------------------------------------------------
# Install Confd - Manage local application configuration files using templates

CONFD_VER=0.6.3 && curl -o /usr/local/bin/confd -SL https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VER}/confd-${CONFD_VER}-linux-amd64 \
  && chmod +x /usr/local/bin/confd \
  && mkdir -p /etc/confd/conf.d && mkdir /etc/confd/templates

