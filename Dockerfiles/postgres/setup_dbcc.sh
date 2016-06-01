

# -------------------------------------------------------------------------------
# Install dbcc - "Database superuser agent: Listen http port, 
#   check if given database & user exists and create them otherwise"

# https://github.com/LeKovr/dbcc/releases/download/v1.6/dbcc_linux_amd64.zip

VER=v1.6 && NAME=dbcc_linux_$(dpkg --print-architecture) \
  && curl -OL https://github.com/LeKovr/dbcc/releases/download/${VER}/$NAME.zip \
  && unzip $NAME.zip && rm $NAME.zip \
  && mv $NAME /usr/local/bin/dbcc
