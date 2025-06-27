#!/usr/bin/env bash

echo "Starting $(basename "$0")" "$@"

backlight_device="dell::kbd_backlight"

function safeeyes_handler {

  if [[ ${1:0:10} == "openwindow" ]]; then
    if [[ $(cut -d "," -f 2,3,4 <<<"${1:12}") =~ ^special:safeeyes,safeeyes,SafeEyes-[0-9]$ ]]; then
      brightnessctl --device="$backlight_device" -s set 0
      hyprctl dispatch submap safeeyes
      echo "SafeEyes window opened"

    fi
  elif [[ ${1} == "destroyworkspace>>special:safeeyes" ]]; then
    hyprctl dispatch submap reset
    brightnessctl --device="$backlight_device" -r
    echo "SafeEyes window closed"
  fi
}

socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do safeeyes_handler "$line"; done
