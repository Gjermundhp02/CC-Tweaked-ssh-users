#!/usr/bin/env bash

# getent group ccTweaked | awk '{n=split($1,A,":"); print A[n]}'

while IFS= read -r computer; do
  computer_id="$(basename "${computer}")"
  user_name="${computer_id}"

  if test -f "${computer}/authorized_keys.lua"; then
    if ! id -u "${user_name}" >/dev/null 2>&1; then
      printf 'Creating user %s\n' "${user_name}"
      useradd --badname \
              --home-dir "/data/world/computercraft/computer/${computer_id}" \
              --gid "cc" \
              --shell "$(which bash)" \
              "${user_name}"
    fi
  else
    if id -u "${user_name}" >/dev/null 2>&1; then
      printf 'Deleting user %s\n' "${user_name}"
      userdel --force "${user_name}"
    fi
  fi
done < <(find /data/world/computercraft/computer -maxdepth 1 -mindepth 1 -type d)

