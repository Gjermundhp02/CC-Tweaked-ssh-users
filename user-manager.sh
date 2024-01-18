#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

BASE_DIR="/data/world/computercraft/computer"

recurse_computers () {
  while IFS= read -r computer; do
    computer_id="$(basename "${computer}")"
    user_name="cc${computer_id}"

    if test -f "${computer}/authorized_keys.lua"; then
      if ! id -u "${user_name}" >/dev/null 2>&1; then
        printf 'Creating user %s\n' "${user_name}"
        useradd --badname \
                --home-dir "${computer}" \
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
  done < <(find "${BASE_DIR}" -maxdepth 1 -mindepth 1 -type d)
}

recurse_computers
printf 'Setting up watchers for %s\n' "${BASE_DIR}"
mkdir -p "${BASE_DIR}"
inotifywait --monitor \
            --recursive \
            --quiet \
            --event create \
            --format '%w %f' \
            "${BASE_DIR}" \
            | while read directory file; do
  if test "${file}" = "authorized_keys.lua" -a -f "${directory}${file}"; then
    recurse_computers
  fi
done
