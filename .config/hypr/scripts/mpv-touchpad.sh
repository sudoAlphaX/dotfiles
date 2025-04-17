#!/usr/bin/env bash

# Track mpv activewindow state
is_mpv_active=0
is_mpv_fullscreen=0

# Main handler function
mpv_handler() {
  local event="$1"

  # Update MPV active status
  if [[ "$event" =~ ^activewindow\>\> ]]; then
    # Update MPV active status
    if [[ "$event" =~ ^activewindow\>\>mpv ]]; then
      if [[ $is_mpv_fullscreen -eq 1 ]]; then
        disable_touchpad
      fi
      is_mpv_active=1
    else
      if [[ $is_mpv_active -eq 1 && $is_mpv_fullscreen -eq 1 ]]; then
        enable_touchpad
      fi
      is_mpv_active=0
    fi
  fi

  # Handle fullscreen state changes only when mpv is active
  if [[ "$event" =~ ^fullscreen\>\> && $is_mpv_active -eq 1 ]]; then
    if [[ "$event" =~ ^fullscreen\>\>1 ]]; then
      is_mpv_fullscreen=1
      disable_touchpad
    elif [[ "$event" =~ ^fullscreen\>\>0 ]]; then
      is_mpv_fullscreen=0
      enable_touchpad
    fi
  fi
}

disable_touchpad() {
  "$(dirname "$0")/touchpad-toggle.sh" false >/dev/null
}

enable_touchpad() {
  "$(dirname "$0")/touchpad-toggle.sh" true >/dev/null
}

# Connect to Hyprland socket and process events
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
  mpv_handler "$line"
done
