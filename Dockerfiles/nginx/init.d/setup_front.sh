#
# Setup nginx frontend server
# if container started with ENV{MODE} == "common"
#

if [[ "$MODE" == "$FRONT_MODE" ]] ; then
  echo "Setup nginx frontend"

  # activate nginx front config in front mode
  CONF=/etc/nginx/conf.d/nginx-front.conf
  [ -e $CONF ] && rm $CONF
  consul-template -once -template=/etc/consul/src/nginx-front.conf:$CONF

  echo "Done"
fi

