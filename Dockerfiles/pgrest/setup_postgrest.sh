
# -------------------------------------------------------------------------------
# Install Postgrest

# https://github.com/begriffs/postgrest/releases/download/v0.2.11.1/postgrest-0.2.11.1-linux.tar.xz

USER=begriffs && PRJ=postgrest && VER=0.2.11.1 && NAME=${PRJ}-${VER}-linux \
  && curl -OL https://github.com/${USER}/${PRJ}/releases/download/v${VER}/${NAME}.tar.xz \
  && tar -xaf ${NAME}.tar.xz \
  && sudo mv ${PRJ}-${VER} /usr/local/sbin/${PRJ} \
  && rm ${PRJ}*
