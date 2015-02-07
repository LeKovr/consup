
# -------------------------------------------------------------------------------
# Install Consul-template


CONSUL_TMPL_VER=0.6.1 && curl -OL https://github.com/hashicorp/consul-template/releases/download/v${CONSUL_TMPL_VER}/consul-template_${CONSUL_TMPL_VER}_linux_amd64.tar.gz \
  && tar -xzf consul-template_${CONSUL_TMPL_VER}_linux_amd64.tar.gz \
  && mv consul-template_${CONSUL_TMPL_VER}_linux_amd64/consul-template /usr/local/bin/ \
  && rm consul-template_${CONSUL_TMPL_VER}_linux_amd64.tar.gz \
  && rmdir consul-template_${CONSUL_TMPL_VER}_linux_amd64 \
  && mkdir -p /etc/consul/templates
