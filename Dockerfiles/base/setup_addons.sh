# -------------------------------------------------------------------------------
# Install jq - command-line JSON processor

curl -o /usr/local/bin/jq -SL http://stedolan.github.io/jq/download/linux64/jq \
  && chmod +x /usr/local/bin/jq

# -------------------------------------------------------------------------------
# Install gosu - "run this specific application as this specific user and get out of the pipeline"

GOSU_VER=1.1 && curl -o /usr/local/bin/gosu -SL https://github.com/tianon/gosu/releases/download/${GOSU_VER}/gosu \
  && chmod +x /usr/local/bin/gosu

# -------------------------------------------------------------------------------
# Install Confd - Manage local application configuration files using templates

CONFD_VER=0.6.3 && curl -o /usr/local/bin/confd -SL https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VER}/confd-${CONFD_VER}-linux-amd64 \
  && chmod +x /usr/local/bin/confd \
  && mkdir -p /etc/confd/conf.d && mkdir /etc/confd/templates

# -------------------------------------------------------------------------------
# Install Consul - tool for service discovery, monitoring and configuration
# http://brian.akins.org/blog/2014/05/03/simple-consul-example/

CONSUL_VER=0.4.1 && curl -OL https://dl.bintray.com/mitchellh/consul/${CONSUL_VER}_linux_amd64.zip \
  && unzip ${CONSUL_VER}_linux_amd64.zip \
  && chmod +x consul \
  && mv consul /usr/local/bin/ \
  && rm ${CONSUL_VER}_linux_amd64.zip \
  && mkdir -p /etc/consul.d \
  && groupadd -r consul && useradd -r -g consul consul \
  && mkdir /var/lib/consul \
  && chown consul:consul /var/lib/consul


