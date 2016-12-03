
# -------------------------------------------------------------------------------
# Install Consul - tool for service discovery, monitoring and configuration
# http://brian.akins.org/blog/2014/05/03/simple-consul-example/

VER=0.7.1 && NAME=consul_${VER}_linux_$(dpkg --print-architecture) \
  && curl -OL https://releases.hashicorp.com/consul/${VER}/${NAME}.zip \
  && unzip ${NAME}.zip \
  && rm ${NAME}.zip \
  && mv consul /usr/local/bin/ \
  && mkdir -p /etc/consul/conf.d \
  && mkdir /var/lib/consul
