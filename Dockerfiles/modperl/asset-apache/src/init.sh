#!/bin/bash

cd /opt/src

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y install curl

# -------------------------------------------------------------------------------
# generate .deb

DIR=tmp

[ -d $DIR ] || mkdir $DIR
cd $DIR

# ~50Mb of gcc etc
apt-get -y install wget libgdbm-dev libperl-dev patch checkinstall libwww-perl

[ -f apache_1.3.42.tar.gz ] || wget http://archive.apache.org/dist/httpd/apache_1.3.42.tar.gz
[ -d apache_1.3.42 ] && rm -rf apache_1.3.42
tar xzvf apache_1.3.42.tar.gz

  # http://www.apache.org/dyn/closer.cgi/perl/mod_perl-1.31.tar.gz
[ -f mod_perl-1.31.tar.gz ] ||  wget http://apache-mirror.rbc.ru/pub/apache/perl/mod_perl-1.31.tar.gz
[ -d mod_perl-1.31 ] && rm -rf mod_perl-1.31
tar xzvf mod_perl-1.31.tar.gz

  # http://www.cpan.org/modules/by-module/Apache/libapreq-1.34.tar.gz
[ -f libapreq-1.34.tar.gz ] || wget http://apache.org/dist/httpd/libapreq/libapreq-1.34.tar.gz
[ -d libapreq-1.34 ] && rm -rf libapreq-1.34
tar xzvf libapreq-1.34.tar.gz

# fix: echo
[ -f /bin/sh.old ] || {  mv /bin/sh /bin/sh.old ; ln -s /bin/bash /bin/sh ; }

# getline patch
patch -p0  < ../getline.patch
# mod_perl patch
cd mod_perl-1.31
patch -p1 < ../../perl-1.14.patch

# make them all
perl Makefile.PL APACHE_SRC=../apache_1.3.42/src DO_HTTPD=1 USE_APACI=1 EVERYTHING=1 ADD_MODULE="rewrite,usertrack"
make && make test && checkinstall --install --nodoc --pkgname mod_perl-1.31 -y --exclude=/opt/*
mv *.deb /opt/

cd ../apache_1.3.42
checkinstall --install --nodoc --pkgname apache-1.3.42 -y
mv *.deb /opt/

cd ../libapreq-1.34
perl Makefile.PL
make && checkinstall --install --nodoc --pkgname libapreq-1.34 -y --exclude=/usr/local/lib/perl/5.14.2/perllocal.pod
mv *.deb /opt/
