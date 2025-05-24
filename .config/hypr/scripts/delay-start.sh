#!/usr/bin/sh

: "${2:=5}"

until [ "$(pgrep -x -u "$(whoami)" "$1")" ]; do sleep 1; done

sleep "$2"

exit 0
