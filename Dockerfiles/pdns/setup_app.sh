
# -------------------------------------------------------------------------------
# Install App

apt-get update \
  && apt-get -y install \
    postgresql-client \
    pdns-backend-pgsql \
  && rm -f /etc/powerdns/pdns.d/pdns.simplebind
