# consup_prosody
# Consup procody xmpp server image
# See https://github.com/LeKovr/consup
#

FROM lekovr/consup_baseapp

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

ENV DOCKERFILE_VERSION  150428

# -------------------------------------------------------------------------------
# Install PG client

RUN apt-get -y install \
    postgresql-client \
    lsb-release

# -------------------------------------------------------------------------------
RUN echo deb http://packages.prosody.im/debian $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list && \
  wget https://prosody.im/files/prosody-debian-packages.key -O- | sudo apt-key add - && \
  apt-get update && \
  apt-get -y install prosody


# -------------------------------------------------------------------------------
# Setup Consup client

#COPY consul /etc/consul
#COPY init.d /init.d
COPY supervisor.d /etc/supervisor/conf.d

WORKDIR /home/app

# access log only, errors go to supervisor
VOLUME ["/var/log/prosody"]

EXPOSE 5222 5469

