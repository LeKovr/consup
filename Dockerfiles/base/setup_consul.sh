
# -------------------------------------------------------------------------------
# Install Consul - tool for service discovery, monitoring and configuration
# http://brian.akins.org/blog/2014/05/03/simple-consul-example/

VER=0.5.2 && NAME=${VER}_linux_${DOCKER_ARCH} \
  && curl -OL https://dl.bintray.com/mitchellh/consul/${NAME}.zip \
  && unzip ${NAME}.zip \
  && rm ${NAME}.zip \
  && mv consul /usr/local/bin/ \
  && mkdir -p /etc/consul/conf.d \
  && mkdir /var/lib/consul
