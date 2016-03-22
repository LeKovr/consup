
# -------------------------------------------------------------------------------
# Setup base packages and supervisor
apt-get update \
  && apt-get upgrade -y --no-install-recommends \
  && apt-get install \
    wget curl mc python-setuptools jq ca-certificates unzip xz-utils gawk apt-transport-https git make sudo \
    -y --no-install-recommends \
  && easy_install supervisor \
  && groupadd supervisor \
  && mkdir -p /var/run/supervisor \
  && echo "alias svd=\"supervisorctl -c /etc/supervisor/supervisord.conf\"" >> /root/.bashrc \
  && echo "alias srv=\"curl http://localhost:8500/v1/catalog/services?pretty=1\"" >> /root/.bashrc
