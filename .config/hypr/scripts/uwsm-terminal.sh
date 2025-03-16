#!/usr/bin/bash

uwsm app -a "$(echo "$2" | awk '{printf $1}')" -- $1 "${@:2}"
