
# -------------------------------------------------------------------------------
# Install Consul-template


VER=0.10.0 && NAME=consul-template_${VER}_linux_${DOCKER_ARCH} \
  && curl -OL https://github.com/hashicorp/consul-template/releases/download/v${VER}/${NAME}.tar.gz \
  && tar -xzf ${NAME}.tar.gz \
  && mv ${NAME}/consul-template /usr/local/bin/ \
  && rm ${NAME}.tar.gz \
  && rmdir ${NAME} \
  && mkdir -p /etc/consul/templates
