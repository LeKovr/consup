
# -------------------------------------------------------------------------------
# Install App

# https://releases.mattermost.com/3.0.3/mattermost-team-3.0.3-linux-amd64.tar.gz

VER=3.1.0
DEST=/opt
setup() {
  local prj=$1
  local name=${prj}-team-$VER-linux-amd64
  echo "Setup $prj v $VER"
  curl -OL https://releases.mattermost.com/$VER/$name.tar.gz \
    && tar -xaf $name.tar.gz \
    && mv $prj $DEST/$prj \
    && rm -rf $name.tar.gz
}

setup mattermost

CFG=/opt/mattermost/config/config.json
mv $CFG $CFG.orig
