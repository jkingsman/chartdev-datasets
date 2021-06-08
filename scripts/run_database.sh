#!/usr/bin/env bash
set -ex

docker build -t chartdev-datasets .

docker run --name chartdev-datasets-$RANDOM \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=hunter2 \
    chartdev-datasets
