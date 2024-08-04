until [ "$(pidof "$1")" ]; do sleep 1; done
if [ $# -eq 3 ]; then sleep "$3"; else sleep 1; fi
$2 &
