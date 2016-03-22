
# -------------------------------------------------------------------------------
# Install gosu - "run this specific application as this specific user and get out of the pipeline"

VER=1.7 \
  && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/${VER}/gosu-$(dpkg --print-architecture)" \
  && chmod +x /usr/local/bin/gosu
