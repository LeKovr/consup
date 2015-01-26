
# -------------------------------------------------------------------------------
# Install gosu - "run this specific application as this specific user and get out of the pipeline"

GOSU_VER=1.2 && curl -o /usr/local/bin/gosu -SL https://github.com/tianon/gosu/releases/download/${GOSU_VER}/gosu-amd64 \
  && chmod +x /usr/local/bin/gosu
