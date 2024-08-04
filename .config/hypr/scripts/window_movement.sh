#!/bin/bash

read -r direction value
value="${value:-10}"

activewindow=$(hyprctl -j activewindow)
isFloat=$(echo "$activewindow" | jq .floating)

if [ "$isFloat" = true ]; then
  declare -A movemaps=(["l"]=" -$value 0" ["r"]="$value 0" ["u"]="0 -$value" ["d"]="0 $value")
  hyprctl dispatch moveactive "${movemaps[$direction]}"
else
  hyprctl dispatch swapwindow "$direction"
fi
