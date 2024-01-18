#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

while IFS= read -r computer; do
  computer_id="$(basename "${computer}")"
  user_name="cc${computer_id}"

  if test -f "${computer}/authorized_keys.lua"; then
    if ! id -u "${user_name}" >/dev/null 2>&1; then
      printf 'Creating user %s\n' "${user_name}"
      useradd --badname \
              --home-dir "${computer}" \
              --gid "cc" \
              --shell "$(which bash)" \
              "${user_name}"
      setfacl -R -m "u:${user_name}:rwx" "${computer}"
    fi
  else
    if id -u "${user_name}" >/dev/null 2>&1; then
      printf 'Deleting user %s\n' "${user_name}"
      userdel --force "${user_name}"
    fi
  fi
done < <(find /data/world/computercraft/computer -maxdepth 1 -mindepth 1 -type d)

