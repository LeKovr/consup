
# -------------------------------------------------------------------------------
# Install gosu - "run this specific application as this specific user and get out of the pipeline"

VER=1.4 && NAME=${VER}/gosu-${DOCKER_ARCH} \
 && curl -o /usr/local/bin/gosu -SL https://github.com/tianon/gosu/releases/download/${NAME} \
 && chmod +x /usr/local/bin/gosu
