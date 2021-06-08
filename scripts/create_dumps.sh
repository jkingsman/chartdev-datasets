#!/usr/bin/env bash
set -ex

docker exec $CONTAINER_ID bash -c 'export PGUSER=chartdev; export PGPASSWORD=marten; pg_dump -h 127.0.0.1 chinook -O -C -x' | gzip > data/10-chinook.sql.gz;
docker exec $CONTAINER_ID bash -c 'export PGUSER=chartdev; export PGPASSWORD=marten; pg_dump -h 127.0.0.1 dundersign -O -C -x' | gzip > data/20-dundersign.sql.gz;
docker exec $CONTAINER_ID bash -c 'export PGUSER=chartdev; export PGPASSWORD=marten; pg_dump -h 127.0.0.1 ufosightings -O -C -x' | gzip > data/30-ufosightings.sql.gz;
