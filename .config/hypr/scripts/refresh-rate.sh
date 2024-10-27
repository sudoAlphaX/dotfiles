#!/bin/bash

lowrate=48
maxrate=60

if [[ "$1" = "low" ]]; then
  hyprctl keyword -r '$refresh_rate' $lowrate
elif [[ "$1" = "high" ]]; then
  hyprctl keyword -r '$refresh_rate' $maxrate
fi
