

# -------------------------------------------------------------------------------
# Install dbrpc - RPC server for database stored procedures

# https://github.com/LeKovr/dbrpc/releases/download/v0.1/dbrpc_linux_amd64.zip

PRJ=dbrpc && VER=0.4
echo "Setup $PRJ v $VER"
NAME=${PRJ}_linux_$(dpkg --print-architecture) \
  && curl -OL https://github.com/LeKovr/dbrpc/releases/download/v${VER}/$NAME.zip \
  && unzip $NAME.zip && rm $NAME.zip \
  && mv $NAME /usr/local/sbin/${PRJ}
