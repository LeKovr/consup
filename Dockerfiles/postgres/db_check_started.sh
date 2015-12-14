#!/bin/bash

# Check when DB begins accept connections & reload consul after
echo "Wait for PG"
while ! gosu postgres check_postgres.pl --action connection >/dev/null ; do
sleep 1
done

echo "PG ready. Start Consul"
supervisorctl -c /etc/supervisor/supervisord.conf start consul

echo "Start dbcc"
supervisorctl -c /etc/supervisor/supervisord.conf start dbcc

echo "Done"
# Say all is Ok to supervisor
exit 0
