#!/usr/bin/env bash

# Track mpv activewindow state
is_mpv_active=0

# Main handler function
mpv_handler() {
  local event="$1"

  # Handle window focus changes
  if [[ "$event" =~ ^activewindow\>\> ]]; then
    # Update MPV active status
    if [[ "$event" =~ ^activewindow\>\>mpv ]]; then
      if [[ $is_mpv_active -eq 0 ]]; then
        is_mpv_active=1
      fi
    else
      if [[ $is_mpv_active -eq 1 ]]; then
        ./touchpad-toggle.sh true >/dev/null
      fi
      is_mpv_active=0
    fi
    return
  fi

  # Only process fullscreen events if MPV is the active window
  if [[ $is_mpv_active -eq 1 ]]; then
    if [[ "$event" == "fullscreen>>1" ]]; then
      ./touchpad-toggle.sh false >/dev/null
    elif [[ "$event" == "fullscreen>>0" ]]; then
      ./touchpad-toggle.sh true >/dev/null
    fi
  fi
}

# Connect to Hyprland socket and process events
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
  mpv_handler "$line"
done
