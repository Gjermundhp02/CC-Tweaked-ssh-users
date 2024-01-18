#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

/user-manager.sh &

if test -n "${DEBUG:-}"; then
  mkdir -p /run/sshd
  chown root:root /run/sshd
  chmod 0755 /run/sshd
  /usr/sbin/sshd -d
else
  service ssh start
  /start ${@}
fi
