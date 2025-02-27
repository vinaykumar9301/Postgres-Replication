#!/bin/bash
set -e

psql -U $POSTGRES_USER -d $POSTGRES_DB <<-EOSQL
    CREATE ROLE $REPLICATION_USER WITH REPLICATION PASSWORD '$REPLICATION_PASSWORD' LOGIN;
EOSQL
