#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

service ssh start
mkdir -p /data/world/computercraft/computer

read
/start ${@}
