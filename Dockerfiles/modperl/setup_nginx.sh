
# -------------------------------------------------------------------------------
# Install nginx

apt-get install -y nginx-extras \
  && sed -i.bak \
      -e 's|access_log .*|access_log  off;|' \
      -e 's|error_log .*|error_log  /dev/stderr notice;|' \
      -e 's|$remote_addr|$http_x_real_ip|' \
      /etc/nginx/nginx.conf \
  && mkdir /etc/nginx/certs \
  || exit 1

# TODO: remove after checking realip via proxy
#      -e 's| "$http_x_forwarded_for"||' \
