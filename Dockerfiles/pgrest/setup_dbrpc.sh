

# -------------------------------------------------------------------------------
# Install dbrpc - RPC server for database stored procedures

# https://github.com/LeKovr/dbrpc/releases/download/v0.1/dbrpc_linux_amd64.zip

VER=v0.1 && NAME=dbrpc_linux_$(dpkg --print-architecture) \
  && curl -OL https://github.com/LeKovr/dbrpc/releases/download/${VER}/$NAME.zip \
  && unzip $NAME.zip && rm $NAME.zip \
  && mv $NAME /usr/local/sbin/dbrpc
