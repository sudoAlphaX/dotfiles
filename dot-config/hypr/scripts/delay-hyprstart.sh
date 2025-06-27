#!/usr/bin/env sh

echo "Starting $(basename "$0")" "$@"

delay="$1"

: "${delay:=1}"

while true; do
  if hyprctl version 2>/dev/null | grep -q "^Hyprland"; then
    break
  fi
  sleep 1
done

sleep "$delay"
