#!/bin/bash
while IFS= read -r computer; do
  if test -f "${computer}/authorized_keys.lua"; then
    cat "${computer}/authorized_keys.lua" | head -1
  fi
done < <(find /data/world/computercraft/computer -maxdepth 1 -mindepth 1 -type d)