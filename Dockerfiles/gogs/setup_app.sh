
# -------------------------------------------------------------------------------
# Install App

#https://github.com/gogits/${PRJ}/releases/download/${VER}/linux_amd64.tar.gz

VER=v0.11.4 && PRJ=gogs \
  && echo "Setup $PRJ $VER" \
  && NAME=${PRJ}_${VER}_linux_amd64 \
  && curl -OL https://github.com/gogits/${PRJ}/releases/download/${VER}/linux_amd64.tar.gz \
  && tar -xzf linux_amd64.tar.gz -C /opt \
  && rm linux_amd64.tar.gz

