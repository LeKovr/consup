# PGWS staff
# Install PGWS (https://github.com/LeKovr/pgws/) project required libs

apt-get -y install file libjson-perl libwww-perl cpanminus \
 libfcgi-procmanager-perl libcache-fastmmap-perl \
 libcgi-simple-perl libdbi-perl libdbd-pg-perl libfcgi-perl \
 liblocale-maketext-lexicon-perl liblocale-maketext-simple-perl \
 libtemplate-perl libmime-perl libipc-shareable-perl liburi-perl \
 libtext-multimarkdown-perl libtext-diff-perl \
 libany-moose-perl libxml-simple-perl \
 libsoap-lite-perl libio-string-perl

cpanm FCGI::Client
