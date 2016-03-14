
# -------------------------------------------------------------------------------
# Install Postgrest

# https://github.com/begriffs/postgrest/releases/download/v0.2.11.1/postgrest-0.2.11.1-linux.tar.xz
#  https://github.com/begriffs/postgrest/releases/download/v0.3.0.1/postgrest-0.3.0.1-ubuntu.tar.xz

USER=begriffs && PRJ=postgrest && VER=0.3.1.0 && NAME=${PRJ}-${VER}-ubuntu \
  && curl -OL https://github.com/${USER}/${PRJ}/releases/download/v${VER}/${NAME}.tar.xz \
  && tar -xaf ${NAME}.tar.xz \
  && sudo mv ${PRJ} /usr/local/sbin/${PRJ} \
  && rm ${PRJ}*
