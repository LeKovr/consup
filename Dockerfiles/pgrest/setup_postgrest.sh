
# -------------------------------------------------------------------------------
# Install Postgrest

VER=0.2.11.1 && NAME=postgrest-${VER} \
  && curl -OL https://github.com/begriffs/postgrest/releases/download/v${VER}/${NAME}-linux.tar.xz \
  && tar -xJf ${NAME}-linux.tar.xz \
  && mv ${NAME} /usr/local/sbin/ \
  && rm ${NAME}-linux.tar.xz \
  && ln -s ${NAME} /usr/local/sbin/postgrest
