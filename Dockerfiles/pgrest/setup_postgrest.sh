
# -------------------------------------------------------------------------------
# Install Postgrest

#https://github.com/begriffs/postgrest/releases/download/v0.2.12.0/postgrest-0.2.12.0-ubuntu.tar.xz

USER=begriffs && PRJ=postgrest && VER=0.2.11.1 && NAME=${PRJ}-${VER}-ubuntu \
  && curl -OL https://github.com/${USER}/${PRJ}/releases/download/v${VER}/${NAME}.tar.xz \
  && tar -xaf ${NAME}.tar.xz \
  && mv ${PRJ}-${VER} /usr/local/sbin/${PRJ} \
  && rm ${PRJ}*
