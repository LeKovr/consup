
# -------------------------------------------------------------------------------
# Install App

# https://github.com/LeKovr/webhook/releases/download/2.3.6/webhook_linux_amd64.tar.gz
# https://github.com/adnanh/webhook/releases/download/2.6.0/webhook-linux-amd64.tar.gz

VENDOR=adnanh && PRJ=webhook && VER=2.6.0 && NAME=${PRJ}-linux-amd64 \
  && curl -OL https://github.com/$VENDOR/$PRJ/releases/download/$VER/$NAME.tar.gz \
  && tar -xf ${NAME}.tar.gz \
  && mv ${NAME}/${PRJ} /usr/local/sbin/ \
  && rm -rf ${NAME}
