
# Consul UI init script

CONSUL_VER=0.7.5


cd /home/app

# load local copy for customize
if [ ! -d html ] ; then
  echo "Getting web ui..."
  VER=$CONSUL_VER && NAME=consul_${VER}_web_ui \
    && curl -OL https://releases.hashicorp.com/consul/${VER}/${NAME}.zip \
    && unzip ${NAME}.zip -d html \
    && rm ${NAME}.zip || exit 1
    echo "Web UI ready"
fi

# health check & service name
cat > /etc/consul/conf.d/consul-ui.json << EOF
{
  "service": {
    "name": "internal",
    "tags": ["${NODENAME}"],
    "port": 8500,
    "check": {
      "script": "curl -s localhost:8500 2>&1",
      "interval": "10s"
    }
  }
}
EOF

# startup
cat > /etc/supervisor/conf.d/consul.conf << EOF
[program:consul]
command = /usr/local/bin/consul agent -config-dir /etc/consul/conf.d -join %(ENV_CONSUL_MASTER)s -client 0.0.0.0 -ui -ui-dir /home/app/html
stopsignal = INT
EOF
