#!/usr/bin/env bash
set -ex

docker build -t jkingsman/chartdev-datasets:latest -t "jkingsman/chartdev-datasets:$(git rev-parse --short HEAD)" .
docker push "jkingsman/chartdev-datasets:$(git rev-parse --short HEAD)"
