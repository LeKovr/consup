#!/bin/bash
# Save domain data
# Usage:
#   docker exec -ti demo_dns.consup_master dbsave_pdns.sh

# strict mode http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

D=/home/app/pdns-$(date +"%y%m%d")
echo $D
[ -d $D ] || mkdir $D
chmod 777 $D

PGPASSWORD=$DB_PASS psql -X -h $PG_HOST -U $DB_NAME << EOF
\copy (select * from domains order by 1) to $D/domains.txt
\copy (select * from domainmetadata order by 2,3) to $D/domainmetadata.txt
\copy (select * from records order by 2,3,4) to $D/records.txt
EOF
