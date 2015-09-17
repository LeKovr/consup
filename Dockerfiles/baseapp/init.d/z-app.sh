
# Run app init script if exists
D="/home/app"

# Run code before services started
if [ -d "$D" ] && [ -e "$D/init.sh" ]; then
  . $D/init.sh
fi

# Run code after services started
if [ -d "$D" ] && [ -e "$D/onboot.sh" ]; then
  nohup bash $D/onboot.sh > $D/onboot.log 2>&1 &
  chmod a+r $D/onboot.log
fi
