#
# Manage nginx SSL via acmetool
# Copyright (c) 2016 Alexey Kovrizhkin <ak@elfire.ru>
#
# This script called everytime when web services list changed via
# $ consul watch -type=service -service=web bash /etc/nginx/acme_mgr.sh
#
# To register email call:
# $ docker exec consup_nginx_common curl -s -X PUT -d "user@host" http://localhost:8500/v1/kv/conf/https/email
#
# See also
# * [consup](https://github.com/LeKovr/consup)
# * [acmetool](https://github.com/hlandau/acme)

# ------------------------------------------------------------------------------

ver="1.1"

# consul K/V storage path for cert's owner email
KV_EMAIL=conf/https/email

# acmetool state dir
ACME_ROOT=/opt/acme
hooks=/usr/lib/acme/hooks
hook=$hooks/reload

# ------------------------------------------------------------------------------

# strict mode http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# logging func
log() {
  D=$(date "+%F %T")
  echo  "$D $1"
}

# ------------------------------------------------------------------------------

log "***** Run acme_mgr.sh v$ver ***"

# Fetch email from consul
CERT_EMAIL=$(curl -s http://localhost:8500/v1/kv/$KV_EMAIL | jq -r '.[] | .Value' | base64 -d)

[[ "$CERT_EMAIL" ]] || { log "No cert owner's email => no certs, exiting" ; exit ; }

log "Setup cert config for $CERT_EMAIL..."

# ------------------------------------------------------------------------------
# Setup SSL
DH=$ACME_ROOT/dhparam.pem

[ -f $DH ] || openssl dhparam -out $DH 2048

# ------------------------------------------------------------------------------
# Setup acmetool quickstart responses

[ -d $ACME_ROOT/conf ] || mkdir $ACME_ROOT/conf
[ -f $ACME_ROOT/conf/responses ] || cat > $ACME_ROOT/conf/responses <<EOF
"acme-enter-email": "$CERT_EMAIL"
"acmetool-quickstart-choose-server": "https://acme-v01.api.letsencrypt.org/directory"
"acme-agreement:https://letsencrypt.org/documents/LE-SA-v1.1.1-August-1-2016.pdf": true
"acmetool-quickstart-choose-method": proxy
"acmetool-quickstart-install-cronjob": false
"acmetool-quickstart-install-haproxy-script": false
EOF

# ------------------------------------------------------------------------------
# Setup cron

[ -f /etc/cron.d/acme ] || cat > /etc/cron.d/acme <<EOF
SHELL=/bin/sh
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
MAILTO=$CERT_EMAIL
53 21 * * * root /usr/bin/acmetool --batch --state="$ACME_ROOT" reconcile
EOF

# ------------------------------------------------------------------------------
# Run quickstart once
[ -d $ACME_ROOT/accounts ] || pgrep acmetool > /dev/null || acmetool quickstart --state="$ACME_ROOT" --batch && rm $hook

# ------------------------------------------------------------------------------
# Setup nginx reload hook

if [ ! -f $hook ] ; then
  cat > $hook <<EOF
#!/bin/sh
set -e
EVENT_NAME="\$1"
[ "\$EVENT_NAME" = "live-updated" ] || exit 42
supervisorctl -c /etc/supervisor/supervisord.conf signal HUP nginx
exit 0
EOF
  chmod a+x $hook
fi

# Nginx reload flag
reload=/tmp/acme-reload
[ -f $reload ] && rm $reload
# ------------------------------------------------------------------------------
# Read STDIN from consul watch

dir=/tmp/acme-active
[ -d $dir ] && rm -rf $dir
mkdir $dir

#log "Check active hosts..."
jq -r '.[] | .Checks[] | if .ServiceName == "web" and .Status == "passing" then .Node else empty end' | while read n ; do
#log "> $n"
  # activate cert request
  [ -f $ACME_ROOT/desired/$n ] || {
    log "New host $n"
    touch $reload
    touch $ACME_ROOT/desired/$n
    # TODO 1st start without redirect to https (no cert yet)
  }
  # generate nginx conf
  [ -f /etc/nginx/conf.d/ssl-$n.conf ] || touch $reload && CERT_HOST=$n consul-template -template=/etc/nginx/ssl.conf:/etc/nginx/conf.d/ssl-$n.conf -once

  # Tag as active
  touch $dir/$n
done

#log "Check inactive hosts..."
find $ACME_ROOT/desired/ -type f -printf %f\\n | while read n ; do
#  log "> $n"
  if [ ! -f $dir/$n ] ; then
    log "Remove host $n"
    [ -f /etc/nginx/conf.d/ssl-$n.conf ] && rm /etc/nginx/conf.d/ssl-$n.conf
    acmetool --state="$ACME_ROOT" --hooks=/usr/lib/acme/hooks unwant $n
    touch $reload
  fi
done

# ------------------------------------------------------------------------------
# update cert list
WASRELOAD=$(acmetool --state="$ACME_ROOT" --hooks=/usr/lib/acme/hooks 2>&1)

# reload nginx if acmetool does not say "nginx: signalled"
[[ "$WASRELOAD" ]] || [ -f $reload ] && $hook live-updated
# ------------------------------------------------------------------------------
log Done
