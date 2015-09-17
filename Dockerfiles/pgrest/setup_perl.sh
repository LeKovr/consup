# Sqitch staff
# http://sqitch.org/

# Does not exists in repos:
# Locale::Messages, Type::Utils,  Moo::sification, StackTrace::Auto, Type::Library, 
# Types::Standard, PerlIO::utf8_strict, Moo::Role, IO::Pager, 
# Locale::TextDomain, Sub::Exporter::Util, String::Formatter, URI::db

# gcc needed only by PerlIO::utf8_strict

apt-get -y install make gawk libjson-perl libwww-perl cpanminus gcc \
 libdbi-perl libdbd-pg-perl \
 liblist-moreutils-perl libsuper-perl libtest-mockmodule-perl \
 libdatetime-locale-perl libdatetime-timezone-perl libdatetime-perl \
 libhash-merge-perl libclone-perl libclass-xsaccessor-perl \
 libcapture-tiny-perl \
 libtest-dir-perl \
 libtest-nowarnings-perl\
 libtest-deep-perl \
 libtest-exception-perl \
 libtest-file-contents-perl \
 libtest-file-perl \
 libpath-class-perl \
 libtemplate-tiny-perl \
 libsub-exporter-perl \
 libdevel-stacktrace-perl \
 libfile-homedir-perl \
 libconfig-gitlike-perl \
 libstring-shellquote-perl \
 libipc-system-simple-perl \
 libthrowable-perl \
 libipc-run3-perl \
 libnamespace-autoclean-perl \
 libmoo-perl \
 libstring-formatter-perl

cpanm App::Sqitch
