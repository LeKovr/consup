# -------------------------------------------------------------------------------
# Setup LANG

# From https://github.com/docker-library/postgres
apt-get install locales
localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
