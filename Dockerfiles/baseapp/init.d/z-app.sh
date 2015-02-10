
# Run app init script if exists
D="/home/app"

if [ -d "$D" ] && [ -e "$D/init.sh" ]; then
  . $D/init.sh
fi
