# consup nodejs
# node.js v6
# See https://github.com/LeKovr/consup
#

FROM lekovr/consup_baseapp

ENV DOCKERFILE_VERSION  161024

RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN sudo apt-get install -y nodejs bzip2 libfontconfig1

# -------------------------------------------------------------------------------
# Extra libs

COPY package.json /root
RUN cd /root \
  && ln -s /usr/lib/node_modules node_modules \
  && npm install --only=dev

# -------------------------------------------------------------------------------
# Consup

WORKDIR /home/app

ENV APPUSER op

COPY init.sh /
CMD ["/init.sh"]
