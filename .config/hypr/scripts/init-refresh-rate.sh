#!/bin/bash

lowrate=48
maxrate=60

if [ "$(cat /sys/class/power_supply/BAT0/status)" == 'Discharging' ]; then
  hyprctl -r keyword '$refresh_rate' $lowrate
else
  hyprctl -r keyword '$refresh_rate' $maxrate
fi
