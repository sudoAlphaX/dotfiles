#!/bin/bash

#set high limits. example: if number is less than 10, it is considered safe.
safe=15
normal=30
# Values greater than $normal will be considered critical.

updates="$(checkupdates --nocolor)"
updatesSanitized="$(echo "$updates" | awk '{printf "%s\\n", $0}')"
updatesCount=$(echo "$updates" | wc -l)

if ((updatesCount <= safe)); then
  exit 0
elif ((updatesCount <= normal)); then
  class="normal"
else
  class="high"
fi

printf '{"text": " %s", "class": "%s", "tooltip": "%s"}\n' "$updatesCount" "$class" "$updatesSanitized"
