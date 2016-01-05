
# Create user & his home dir

home=/home/app/$APPUSER

# Check if user exists already
# grep -qe "^$APPUSER:" /etc/passwd || useradd -m -r -s /bin/bash -Gwww-data -gusers -gsudo $APPUSER
grep -qe "^$APPUSER:" /etc/passwd || useradd -d $home $APPUSER

# DEST Used by gogs install
# This will be removed after switch to consul-template >= 0.11.1
DEST=/opt/gogs/custom/conf
chown -R $APPUSER $DEST

# Mount point owner
chown $APPUSER /home/app

# New uid may be
for dir in data git repos ; do
  [ -d $dir ] || mkdir $dir
  chown -R $APPUSER $dir
done


# Create initial gogs config if none

dest="/opt/gogs/custom/conf/app.ini"

[ -f $dest ] || {
  cat > $dest <<EOF

APP_NAME = Gogs: Go Git Service
RUN_USER = $APPUSER
RUN_MODE = prod

[database]
DB_TYPE = postgres
HOST = $PG_HOST:5432
NAME = $DB_NAME
USER = $DB_NAME
PASSWD = $DB_PASS
SSL_MODE = disable
PATH = data/gogs.db

[repository]
ROOT = /home/app/repos

[server]
DOMAIN = $NODENAME
HTTP_PORT = 3000
ROOT_URL = http://$NODENAME/
DISABLE_SSH = false
SSH_PORT = $SSHD_PORT
OFFLINE_MODE = false

[log]
MODE = file
LEVEL = Info
ROOT_PATH = /home/app/log/gogs

EOF
}
chown $APPUSER $dest

