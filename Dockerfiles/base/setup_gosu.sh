
# -------------------------------------------------------------------------------
# Install gosu - "run this specific application as this specific user and get out of the pipeline"

VER=1.7 && gpg --keyserver pgp.mit.edu --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/${VER}/gosu-$(dpkg --print-architecture)" \
  && curl -o /usr/local/bin/gosu.asc -L "https://github.com/tianon/gosu/releases/download/${VER}/gosu-$(dpkg --print-architecture).asc" \
  && gpg --verify /usr/local/bin/gosu.asc \
  && rm /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu