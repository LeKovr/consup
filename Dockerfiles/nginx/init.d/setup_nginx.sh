#
# Setup nginx frontend server
#

if [[ "$MODE" == "$FRONT_MODE" ]] ; then
  # if container started with ENV{MODE} == "common"
  SRC=/etc/consul/src/nginx-front.conf
  NAME="master proxy"

  cat > /etc/supervisor/conf.d/acme.conf <<EOF
[program:acme]
command=consul watch -type=service -service=web -passingonly=true bash /etc/nginx/acme_mgr.sh
EOF

  cat > /etc/supervisor/conf.d/cron.conf <<EOF
[program:cron]
command = cron -f -L 15
autostart=true
autorestart=true
EOF

elif [[ "$MODE" == "$REDIR_MODE" ]] ; then
  SRC=/etc/consul/src/nginx-redir.conf

elif [[ "$MODE" == "$PROXY_MODE" ]] ; then
  SRC=/etc/consul/src/nginx-proxy.conf

elif [ -f /home/app/nginx.conf ] ; then
  # App got own config
  SRC=/home/app/nginx.conf

else
  # Default site config
  SRC=/etc/consul/src/nginx.conf
fi

echo "Setup nginx for $HOSTNAME"
echo "Config template: $SRC"

CONF=/etc/nginx/conf.d/nginx.conf
[ -e $CONF ] && rm $CONF
consul-template -once -template=$SRC:$CONF

echo "Done"

