
# process templates in first run only
# besause it will hang at second run
# see https://github.com/hashicorp/consul-template/issues/188

flag=/tmp/templates.done
[ -f $flag ] || {
  consul-template -config=/etc/consul/templates/ -once
  touch $flag
}
