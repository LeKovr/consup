
# -------------------------------------------------------------------------------
# Setup nginx repo

apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
  && echo "deb http://nginx.org/packages/mainline/debian/ ${CONSUP_UBUNTU_CODENAME} nginx" > /etc/apt/sources.list.d/nginx.list

# -------------------------------------------------------------------------------
# Install nginx

NGINX_VERSION=1.11.10-1 \
  && apt-get update \
  && apt-get install -y nginx=${NGINX_VERSION}~$CONSUP_UBUNTU_CODENAME cron \
  && apt-get install --only-upgrade libssl1.0.0 openssl \
  && sed -i.bak \
      -e 's|access_log .*|access_log  off;|' \
      -e 's|error_log .*|error_log  /dev/stderr notice;|' \
      -e 's|$remote_addr|$http_x_real_ip|' \
      /etc/nginx/nginx.conf \
  && rm /etc/nginx/conf.d/default.conf \
  || exit 1

# TODO: remove after checking realip via proxy
#      -e 's| "$http_x_forwarded_for"||' \


# -------------------------------------------------------------------------------
# Cleanup nginx repo

rm /etc/apt/sources.list.d/nginx.list
