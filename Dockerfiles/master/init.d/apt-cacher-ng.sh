
# change uid if host storage attached

echo "***** RUN INIT ***"

U="apt-cacher-ng"
D="/var/cache/$U"

DIR_UID=$(stat -c "%u" $D)
if [[ "$DIR_UID" ]] && [[ $DIR_UID != $(id -u $U) ]]; then
  usermod -u $DIR_UID $U
fi

DIR_GID=$(stat -c "%g" $D)
if [[ "$DIR_GID" ]] && [[ $DIR_GID != $(id -g $U) ]]; then
  groupmod -g $DIR_GID $U
  chown $DIR_UID:$DIR_GID /etc/apt-cacher-ng/security.conf
  chown -R $DIR_UID:$DIR_GID /var/log/apt-cacher-ng
fi
