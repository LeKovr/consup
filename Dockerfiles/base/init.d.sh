#!/bin/bash
# strict mode http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Make sure to use all our CPUs, because Consul can block a scheduler thread
export GOMAXPROCS=`nproc`

if [ -d /init.d ]; then
  for f in /init.d/*.sh; do
    [ -f "$f" ] && echo  "Run $f.." && . "$f"
  done
fi

echo "Run main shell.."
exec "$@"
