

# -------------------------------------------------------------------------------
# Install dbrpc - RPC server for database stored procedures

PRJ=dbrpc && VER=0.24
echo "Setup $PRJ v$VER"
NAME=${PRJ}_linux_$(dpkg --print-architecture) \
  && curl -OL https://github.com/LeKovr/dbrpc/releases/download/v${VER}/$NAME.zip \
  && unzip $NAME.zip && rm $NAME.zip \
  && mv $NAME /usr/local/sbin/${PRJ}
