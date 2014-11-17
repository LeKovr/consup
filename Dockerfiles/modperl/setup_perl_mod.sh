
apt-get -y install \
    libexception-class-perl \
    libclass-accessor-perl \
    libapache-dbi-perl \
    libdata-formvalidator-perl \
    libnet-ip-perl \
    libtemplate-perl \
    libmime-tools-perl \
    libjson-xs-perl \
    libauthen-captcha-perl \
    libdbd-pg-perl \
    libfile-desktopentry-perl \
    libtext-iconv-perl \
    libspreadsheet-writeexcel-perl \
    libmldbm-perl \
    libclass-dbi-abstractsearch-perl \
    libnumber-format-perl \
    libxml-libxml-perl \
    libcrypt-ssleay-perl \
    libxml-simple-perl \
    libdata-serializer-perl \
    libwww-perl \
    libhtml-strip-perl \
    libgd-gd2-noxpm-perl \
    libstring-random-perl \
    perlmagick \
    shared-mime-info \
    cpanminus \
    libio-string-perl \
    libspreadsheet-parseexcel-perl \
    libdate-calc-perl || exit 1

cpanm enum \
  && cpanm Toolbox::Simple \
  && cpanm Attribute::Property \
  && cpanm HTML::Restrict \
  && cpanm URI::Escape::JavaScript \
  && cpanm http://www.cpan.org/authors/id/S/SA/SAMTREGAR/HTML-Template-2.9.tar.gz \
  || exit 1

# libhtml-template-perl \
# same as BSD copy
