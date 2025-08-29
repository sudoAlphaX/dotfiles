#!/usr/bin/env sh

echo "Starting $(basename "$0")" "$@"

temp_script="$HOME/.config/waybar/scripts/temperature.sh"
critical_temp=80
refresh_time=10

if [ ! -f "$temp_script" ]; then
  echo "Temperature script not available." >&2
  exit 1
fi

while true; do
  temp="$("$temp_script" | jq -r ".text")"
  if [ "$temp" -ge "$critical_temp" ]; then
    notify-send -u critical -h int:value:"$temp" --category=device temperature_critical_event
    echo "Critical temperature: $temp"
  fi
  sleep "$refresh_time"
done
