
# -------------------------------------------------------------------------------
# Install App

CONF=/etc/powerdns/pdns.conf
apt-get update \
  && apt-get -y install \
    postgresql-client \
    pdns-backend-pgsql \
  && rm -f /etc/powerdns/pdns.d/pdns.simplebind \
  && sed -ri "s/^#\s*(webserver=)no/\1 yes/" $CONF \
  && sed -ri "s/^#\s*(webserver-address=)127.0.0.1/\1 0.0.0.0/" $CONF

