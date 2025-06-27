#!/usr/bin/env sh

echo "Starting $(basename "$0")" "$@"

temp="$("$HOME"/.config/waybar/scripts/temperature.sh | jq -r ".text")"
critical_temp=80
refresh_time=10

if [ -z "$temp" ]; then
  echo "Temperature data not available." >&2
  exit 1
fi

while true; do
  if [ "$temp" -ge "$critical_temp" ]; then
    notify-send -u critical -h int:value:"$temp" --category=device temperature_critical_event
    echo "Critical temperature: $temp"
  fi
  sleep "$refresh_time"
done
