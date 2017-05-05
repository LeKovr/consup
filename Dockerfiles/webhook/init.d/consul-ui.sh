# load local copy for customize
DEST=/home/app/html-ui

if [ ! -d $DEST ] ; then
  echo "Getting web ui..."
  v=$(consul version | head -n 1)
  ver=${X#* v}
  name=consul_${VER}_web_ui
  curl -OL https://releases.hashicorp.com/consul/$ver/$name.zip
  unzip $name.zip -d $DEST
  rm $name.zip
  sed -ri "s/<title>Consul by HashiCorp/<title>Consul - $CONSUP_DOMAIN" html/index.html
  echo "Web UI ready"
fi
