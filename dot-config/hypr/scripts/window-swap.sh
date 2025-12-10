#!/usr/bin/env sh

read -r direction value
value="${value:-10}"

activewindow=$(hyprctl -j activewindow)
isFloat=$(echo "$activewindow" | jq .floating)

if [ "$isFloat" = true ]; then
  hyprctl dispatch movewindow "$direction"
else
  hyprctl dispatch swapwindow "$direction"
fi
