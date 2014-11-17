# modperl meta dockerfile

FROM lekovr/consup_pgws

ENV DOCKERFILE_VERSION  141116

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

# -------------------------------------------------------------------------------
# EXTRA Perl staff

COPY setup_*.sh /opt/
RUN for f in /opt/setup_*.sh ; do . $f ; done && rm /opt/setup_*.sh

# -------------------------------------------------------------------------------
# Install apache-1.3.42 & mod_perl-1.31

COPY asset-apache/*.deb /opt/apache/
RUN cd /opt/apache && dpkg -i *.deb
