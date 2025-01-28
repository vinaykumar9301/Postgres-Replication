#!/bin/bash
set -e

rm -rf /var/lib/postgresql/data/*
pg_basebackup -h postgres-primary -D /var/lib/postgresql/data -U $REPLICATION_USER -v -P --wal-method=stream
echo "standby_mode = 'on'" > /var/lib/postgresql/data/recovery.conf
echo "primary_conninfo = 'host=postgres-primary user=$REPLICATION_USER password=$REPLICATION_PASSWORD'" >> /var/lib/postgresql/data/recovery.conf
chown -R postgres:postgres /var/lib/postgresql/data
