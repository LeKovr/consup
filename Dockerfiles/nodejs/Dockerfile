# consup nodejs
# node.js v 4.2.4 argon

FROM lekovr/consup_baseapp

ENV DOCKERFILE_VERSION  160104

RUN apt-get update && apt-get -y upgrade && apt-get -y install \
    git make g++ libpng-dev

# -------------------------------------------------------------------------------
# The code below is based on official Dockerfile
# https://hub.docker.com/_/node/

# gpg keys listed at https://github.com/nodejs/node
RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

# ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 4.2.4

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --verify SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
  && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc

# -------------------------------------------------------------------------------
# Extra libs

RUN npm install -g gulp bower gulp-jshint gulp-uglify gulp-connect \
  gulp-watch gulp-autoprefixer gulp-less gulp-sourcemaps gulp-rigger gulp-imagemin \
  gulp-cssnano del imagemin-pngquant browser-sync

ENV NODE_PATH /usr/local/lib/node_modules

# -------------------------------------------------------------------------------
# Consup

WORKDIR /home/app

ENV APPUSER op

COPY init.sh /
CMD ["/init.sh"]
