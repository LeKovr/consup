# -------------------------------------------------------------------------------
# Setup nginx

[ -f /etc/nginx/conf.d/log_main.conf ] || {
  cat << 'EOF' > /etc/nginx/conf.d/log_main.conf
  log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';
EOF
}

[ -f /etc/nginx/conf.d/proxied.conf ] || {
  echo "upload_progress proxied 1m;" > /etc/nginx/conf.d/proxied.conf
}
