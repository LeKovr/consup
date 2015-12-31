
# Update gogs distro if there is new version
SRC=/home/app/gogs.zip

if [ -f $SRC  ] ; then
  rm -rf /opt/gogs/public
  rm -rf /opt/gogs/templates
  cd /opt
  unzip -o $SRC
fi
