#!/usr/bin/sh

app="$1"
delay="$2"

: "${delay:=5}"

until [ "$(pgrep -x -u "$(whoami)" "$app")" ]; do sleep 1; done

sleep "$delay"

exit 0
