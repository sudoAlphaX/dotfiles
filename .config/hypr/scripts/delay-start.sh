#!/usr/bin/sh

until [ "$(pgrep -x -u "$(whoami)" "$1")" ]; do sleep 1; done
if [ $# -eq 2 ]; then sleep "$2"; else sleep 5; fi
exit 0
