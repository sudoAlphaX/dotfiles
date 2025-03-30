#!/usr/bin/sh

#set high limits. example: if number is less than 10, it is considered safe.
safe=30
normal=50
# Values greater than $normal will be considered critical.

updates="$(checkupdates --nocolor)"
updatesSanitized="$(echo "$updates" | column -t | awk '{printf "%s\\n", $0}')"
updatesCount=$(echo "$updates" | wc -l)

if [ "$updatesCount" -le "$safe" ]; then
  exit 0
elif [ "$updatesCount" -le "$normal" ]; then
  class="normal"
else
  class="high"
fi

printf '{"text": " %s", "class": "%s", "tooltip": "%s"}\n' "$updatesCount" "$class" "$updatesSanitized"
