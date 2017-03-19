
# -------------------------------------------------------------------------------
# Install Consul-template

VER=0.18.1 && NAME=consul-template_${VER}_linux_$(dpkg --print-architecture) \
  && curl -OL https://releases.hashicorp.com/consul-template/${VER}/${NAME}.zip \
  && unzip ${NAME}.zip \
  && rm ${NAME}.zip \
  && mv consul-template /usr/local/bin/ \
  && mkdir -p /etc/consul/templates
