#!/usr/bin/env bash

# getent group ccTweaked | awk '{n=split($1,A,":"); print A[n]}'

while IFS= read -r computer; do
  if ! test -f "${computer}/authorized_keys.lua"; then
    continue
  fi

  checksum="$(cksum <<< "$(cat "${computer}/authorized_keys.lua")" | awk '{print $1}')"
  if id -u "${checksum}" >/dev/null 2>&1; then
    
  fi
done < <(find /data/world/computercraft/computer -maxdepth 1 -mindepth 1 -type d)

# num_folders="$(grep -oP '(?<="computer": )(\d+)' /data/world/computercraft/ids.json)";
# for i in $(seq 0 $num_folders); do
#     FILE="/data/world/computercraft/computer/${i}/test.lua"
#     if test -f "${FILE}"; then
#       useradd -d "/data/world/computercraft/computer/${i}/" "cc-${i}"
#     fi
# done
