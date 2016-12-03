
# -------------------------------------------------------------------------------
# Install App

#https://github.com/gogits/${PRJ}/releases/download/${VER}/linux_amd64.tar.gz

VER=v0.9.97 && PRJ=gogs \
  && echo "Setup $PRJ $VER" \
  && NAME=${PRJ}_${VER}_linux_amd64 \
  && curl -OL https://github.com/gogits/${PRJ}/releases/download/${VER}/linux_amd64.tar.gz \
  && tar -xzf linux_amd64.tar.gz -C /opt \
  && rm linux_amd64.tar.gz

