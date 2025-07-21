#!/usr/bin/bash

app2unit -t scope -a "$(echo "$2" | awk '{printf $1}')" -- $1 "${@:2}"
