
# setup container uuid for consul
# see https://github.com/hashicorp/consul/issues/2877

export CONSUP_UUID=$(cat /proc/sys/kernel/random/uuid)
