#!/usr/bin/env bash

if test "${#}" -lt "1"; then
  >&2 printf 'Username required.\n'
  exit 1
fi

cat "/data/world/computercraft/computer/${1}/authorized_keys.lua"

# >&2 printf 'Authorizing user %s\n' "${1}"
