#!/usr/bin/env bash

if test "${#}" -lt "1"; then
  >&2 printf 'Username required.\n'
  exit 1
fi

>&2 printf 'Validating user %s\n' "${1}"

username_regex='^cc[0-9]+$'
if [[ ! ${1} =~ ${username_regex} ]]; then
  >&2 printf 'Invalid username: %s\n' "${1}"
  exit 1
fi

>&2 printf 'Authorizing user %s\n' "${1}"

cat "/data/world/computercraft/computer/${1:2}/authorized_keys.lua"

