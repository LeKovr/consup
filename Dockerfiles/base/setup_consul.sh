
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


