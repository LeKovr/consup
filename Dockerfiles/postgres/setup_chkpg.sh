# -------------------------------------------------------------------------------
# Install check_postgres

CHKPG_VER=2.22.0 && curl -OL http://bucardo.org/downloads/check_postgres-${CHKPG_VER}.tar.gz \
  && tar -zxf check_postgres-${CHKPG_VER}.tar.gz \
  && mv check_postgres-${CHKPG_VER}/check_postgres.pl /usr/local/bin/ \
  && rm check_postgres-${CHKPG_VER}.tar.gz \
  && rm -rf check_postgres-${CHKPG_VER}
