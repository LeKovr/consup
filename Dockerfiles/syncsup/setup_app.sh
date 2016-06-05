
# -------------------------------------------------------------------------------

#https://github.com/syncthing/discosrv/releases/download/v0.13.5/discosrv-linux-amd64-v0.13.5.tar.gz
#https://github.com/syncthing/relaysrv/releases/download/v0.13.5/relaysrv-linux-amd64-v0.13.5.tar.gz

USER=syncthing
VER=0.13.5

setup() {
  local prj=$1
  local name=${prj}-linux-amd64-v${VER}
  echo "Setup $prj v $VER"
  curl -OL https://github.com/${USER}/$prj/releases/download/v${VER}/$name.tar.gz \
    && tar -xaf $name.tar.gz \
    && mv $name/$prj /usr/local/sbin/$prj \
    && rm -rf $name*
}

setup discosrv
setup relaysrv
