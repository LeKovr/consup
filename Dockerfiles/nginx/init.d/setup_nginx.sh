#
# Setup nginx frontend server
#

NAME=$PROJECT
if [[ "$MODE" == "$FRONT_MODE" ]] ; then
  # if container started with ENV{MODE} == "common"
  SRC=/etc/consul/src/nginx-front.conf
  NAME="master proxy"
elif [ -f /home/app/nginx.conf ] ; then
  # App got own config
  SRC=/home/app/nginx.conf
else
  # Default site config
  SRC=/etc/consul/src/nginx.conf
fi

echo "Setup nginx for $NAME"
echo "Config template: $SRC"

CONF=/etc/nginx/conf.d/nginx.conf
[ -e $CONF ] && rm $CONF
consul-template -once -template=$SRC:$CONF

echo "Done"

