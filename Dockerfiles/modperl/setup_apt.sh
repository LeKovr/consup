

# -------------------------------------------------------------------------------
# Setup nginx repo

apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
  && echo "deb http://nginx.org/packages/mainline/debian/ ${CONSUP_UBUNTU_CODENAME} nginx" > /etc/apt/sources.list.d/nginx.list
