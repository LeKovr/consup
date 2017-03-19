
# -------------------------------------------------------------------------------
# Setup acmetool

ACME_VER=0.0.59-1xenial1_amd64
ACME_DEB=acmetool_$ACME_VER.deb

[ -f $ACME_DEB ] || wget https://launchpad.net/~hlandau/+archive/ubuntu/rhea/+files/$ACME_DEB
dpkg -i $ACME_DEB
rm $ACME_DEB
