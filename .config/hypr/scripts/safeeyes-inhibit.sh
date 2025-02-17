#!/usr/bin/env bash

function safeeyes-handler {

  if [[ ${1:0:10} == "openwindow" ]]; then
    if [[ $(cut -d "," -f 2,3,4 <<<"${1:12}") =~ ^special:safeeyes,safeeyes,SafeEyes-[0-9]$ ]]; then
      hyprctl dispatch submap safeeyes

    fi
  elif [[ ${1} == "destroyworkspace>>special:safeeyes" ]]; then
    hyprctl dispatch submap reset
  fi
}

socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do safeeyes-handler "$line"; done
