
# -------------------------------------------------------------------------------
# Install App

# https://github.com/LeKovr/webhook/releases/download/2.3.6/webhook_linux_amd64.tar.gz

VENDOR=LeKovr && PRJ=webhook && VER=2.3.8 && NAME=${PRJ}_linux_amd64 \
  && curl -OL https://github.com/$VENDOR/$PRJ/releases/download/$VER/$NAME.tar.gz \
  && tar -xf ${NAME}.tar.gz \
  && mv ${NAME} /usr/local/sbin/${PRJ} \
  && rm ${NAME}*
