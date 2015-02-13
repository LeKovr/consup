# consup image init file
# run at container start

# Generate NGINX config from template
CONF=/etc/nginx/sites-enabled/nginx.conf
[ -L $CONF ] || consul-template -once -template=/home/app/nginx.conf:$CONF

