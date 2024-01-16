#!/usr/bin/env bash

num_folders=$(grep -oP '(?<="computer": )(\d+)' /data/world/computercraft/ids.json);
for i in $(seq 0 $num_folders)
do
    FILE=/data/world/computercraft/computer/${i}/test.lua
    if test -f "$FILE"; then
        useradd -d /data/world/computercraft/computer/${i}/ "ccTweaked${i}"
    fi
done