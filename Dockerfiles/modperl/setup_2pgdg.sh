

# -------------------------------------------------------------------------------

echo "Setup postgresql repo"
echo "deb http://apt.postgresql.org/pub/repos/apt/ ${CONSUP_UBUNTU_CODENAME}-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Add repo key
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
