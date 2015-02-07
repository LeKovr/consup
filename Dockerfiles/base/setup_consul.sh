
# -------------------------------------------------------------------------------
# Install Consul - tool for service discovery, monitoring and configuration
# http://brian.akins.org/blog/2014/05/03/simple-consul-example/

CONSUL_VER=0.4.1 && curl -OL https://dl.bintray.com/mitchellh/consul/${CONSUL_VER}_linux_amd64.zip \
  && unzip ${CONSUL_VER}_linux_amd64.zip \
  && rm ${CONSUL_VER}_linux_amd64.zip \
  && mv consul /usr/local/bin/ \
  && mkdir -p /etc/consul/conf.d \
  && mkdir /var/lib/consul


