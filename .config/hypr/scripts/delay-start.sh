#!/usr/bin/sh

until [ "$(pgrep -x -u "$(whoami)" "$1")" ]; do sleep 1; done
if [ $# -eq 3 ]; then sleep "$3"; else sleep 5; fi
$2 &
