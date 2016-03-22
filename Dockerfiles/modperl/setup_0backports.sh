

# -------------------------------------------------------------------------------
echo "Setup backports repo"
echo "deb http://http.debian.net/debian/ ${CONSUP_UBUNTU_CODENAME}-backports main" > /etc/apt/sources.list.d/backports.list
