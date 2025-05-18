#!/usr/bin/env bash

window=$(hyprctl activewindow -j)
window_id=$(echo "$window" | jq -r .address | sed 's/^0x//g')
window_fullscreen_state=$(echo "$window" | jq -r .fullscreen)

notify-send -a "Hyprland" "Locking screen on window: $(echo "$window" | jq -r ".class")"

if [[ ! "$window_fullscreen_state" -eq 2 ]]; then
  hyprctl dispatch fullscreen 0
fi

function windowlock_handler {

  local event="$1"

  if [[ "$event" =~ ^activewindowv2\>\> ]]; then
    if [[ "$event" != "activewindowv2>>$window_id" ]]; then
      loginctl lock-session
      pkill -P $$ socat
      exit 0
    fi
  fi

}

socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do windowlock_handler "$line"; done
