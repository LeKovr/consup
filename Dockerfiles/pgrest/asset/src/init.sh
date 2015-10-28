#!/bin/bash

cd /opt/src

export DEBIAN_FRONTEND=noninteractive


DIR=tmp

[ -d $DIR ] || mkdir $DIR
cd $DIR

apt-get update && apt-get -y install wget

# Install haskell
# stack
wget -q -O- https://s3.amazonaws.com/download.fpcomplete.com/debian/fpco.key | apt-key add -
echo 'deb http://download.fpcomplete.com/debian/wheezy stable main'| tee /etc/apt/sources.list.d/fpco.list
apt-get update && apt-get -y --force-yes install stack git libpq-dev

# Compile postgrest
git clone https://github.com/begriffs/postgrest.git


cd postgrest
stack setup && \
stack build && \
stack install && \
cp /root/.local/bin/postgrest /opt/src

# remove sources
#cd ../../
#rm -rf tmp

