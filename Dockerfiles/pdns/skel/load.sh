#!/bin/bash

# Script for loading sql into pdns database

# script filename
DOM=$1

# postgres container name
CON=consup_postgres_common

# database name
. .config

cat $DOM | docker exec -i $CON gosu postgres psql $DB_NAME
