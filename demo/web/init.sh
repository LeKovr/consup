# consup image init file
# run at container start

echo "Starting http://$PROJECT site.."

# Generate NGINX config from template
CONF=/etc/nginx/conf.d/nginx.conf
[ -L $CONF ] || consul-template -once -template=/home/app/nginx.conf:$CONF

