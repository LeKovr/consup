
# Create user & his home dir

home=/home/app

# Check if user exists already
# grep -qe "^$APPUSER:" /etc/passwd || useradd -m -r -s /bin/bash -Gwww-data -gusers -gsudo $APPUSER
grep -qe "^$APPUSER:" /etc/passwd || useradd -d $home $APPUSER

# Mount point owner
chown $APPUSER $home

# New uid may be
for d in data ; do
  dir=$home/$d
  [ -d $dir ] || mkdir $dir
  chown -R $APPUSER $dir
done

SRC=/etc/consul/src/config.json
DEST=/home/app/config.json

[ -f $DEST ] || consul-template -once -template=$SRC:$DEST
chown -R $APPUSER $DEST

CONF=/opt/mattermost/config/config.json

[ -f $CONF ] && rm -f $CONF
ln -s $DEST $CONF
