#!/usr/bin/sh

echo "Starting $(basename "$0")" "$@"

temp_script="$HOME/.config/waybar/scripts/temperature.sh"
critical_temp=85
refresh_time=10
critical_count=3 # consecutive over-threshold readings required before notifying

if [ ! -f "$temp_script" ]; then
  echo "Temperature script not available." >&2
  exit 1
fi

breaches=0
while true; do
  temp="$("$temp_script" | jq -r ".text")"
  if [ "$temp" -ge "$critical_temp" ]; then
    breaches=$((breaches + 1))
    if [ "$breaches" -ge "$critical_count" ]; then
      notify-send -u critical -h int:value:"$temp" --category=device temperature_critical_event
      echo "Critical temperature: $temp ($breaches consecutive)"
    fi
  else
    breaches=0
  fi
  sleep "$refresh_time"
done
