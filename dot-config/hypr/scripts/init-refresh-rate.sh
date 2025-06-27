#!/usr/bin/sh

echo "Starting $(basename "$0")" "$@"

lowrate=48
maxrate=60

if systemd-ac-power; then
  hyprctl -r keyword '$refresh_rate' $maxrate
else
  hyprctl -r keyword '$refresh_rate' $lowrate
fi
