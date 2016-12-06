
# -------------------------------------------------------------------------------
# Install WebTail
# https://github.com/LeKovr/webtail/releases/download/v0.1/webtail_linux_amd64.zip

VER=0.6 && NAME=webtail_linux_$(dpkg --print-architecture) \
  && curl -OL https://github.com/LeKovr/webtail/releases/download/v${VER}/${NAME}.zip \
  && unzip ${NAME}.zip \
  && rm ${NAME}.zip README.md \
  && mv $NAME /usr/local/sbin/webtail
