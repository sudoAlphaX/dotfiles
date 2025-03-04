#!/usr/bin/sh

until [ "$(pidof -x -c "$1")" ]; do sleep 1; done
if [ $# -eq 3 ]; then sleep "$3"; else sleep 5; fi
$2 &
