
cd /home/app
if [ ! -d html ] ; then
  echo "Getting web ui..."
  VER=0.7.1 && NAME=consul_${VER}_web_ui \
    && curl -OL https://releases.hashicorp.com/consul/${VER}/${NAME}.zip \
    && unzip ${NAME}.zip -d html \
    && rm ${NAME}.zip || exit 1
    echo "Web UI ready"
fi

cat > /etc/supervisor/conf.d/consul.conf << EOF
[program:consul]
command = /usr/local/bin/consul agent -config-dir /etc/consul/conf.d -join %(ENV_CONSUL_MASTER)s -client 0.0.0.0 -ui -ui-dir /home/app/html
stopsignal = INT
EOF
