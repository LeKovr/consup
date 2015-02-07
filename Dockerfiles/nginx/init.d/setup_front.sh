
DEST=/etc/nginx/sites-enabled/nginx-front.conf
if [[ "$MODE" == "$FRONT_MODE" ]] ; then
  # activate nginx front config in front mode
  [ ! -f $DEST ] && ln -s /etc/nginx/sites-available/nginx-front.conf $DEST
fi

