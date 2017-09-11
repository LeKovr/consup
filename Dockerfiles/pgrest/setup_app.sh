
# -------------------------------------------------------------------------------
# Install Postgrest

# https://github.com/begriffs/postgrest/releases/download/v0.2.11.1/postgrest-0.2.11.1-linux.tar.xz
# https://github.com/begriffs/postgrest/releases/download/v0.4.0.0/postgrest-0.4.0.0-ubuntu.tar.xz

USER=begriffs && PRJ=postgrest && VER=0.4.0.0 && NAME=${PRJ}-${VER}-ubuntu
echo "Setup $PRJ v$VER"
curl -OLsS https://github.com/${USER}/${PRJ}/releases/download/v${VER}/${NAME}.tar.xz \
  && tar -xaf ${NAME}.tar.xz \
  && mv ${PRJ} /usr/local/sbin/${PRJ} \
  && rm ${PRJ}*
