

# -------------------------------------------------------------------------------
# Install dbcc - "Database superuser agent: Listen http port, 
#   check if given database & user exists and create them otherwise"

VER=1.1 && NAME=${VER}/dbcc_linux_${DOCKER_ARCH} \
  && curl -o /usr/local/bin/dbcc -SL https://github.com/LeKovr/dbcc/releases/download/$NAME \
  && chmod +x /usr/local/bin/dbcc
