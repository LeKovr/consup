
# -------------------------------------------------------------------------------
# Install nginx

NGINX_VERSION=1.9.12-1 \
  && apt-get update \
  && apt-get install -y nginx=${NGINX_VERSION}~$CONSUP_UBUNTU_CODENAME \
  && sed -i.bak \
      -e 's|access_log .*|access_log  off;|' \
      -e 's|error_log .*|error_log  /dev/stderr notice;|' \
      -e 's|$remote_addr|$http_x_real_ip|' \
      /etc/nginx/nginx.conf \
  && rm /etc/nginx/conf.d/default.conf \
  && mkdir /etc/nginx/certs \
  || exit 1

# TODO: remove after checking realip via proxy
#      -e 's| "$http_x_forwarded_for"||' \
