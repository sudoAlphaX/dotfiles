#!/usr/bin/env bash

# Track mpv activewindow state
is_mpv_active=0
is_mpv_fullscreen=0

# Keyboard Backlight device
backlight_device="dell::kbd_backlight"
backlight_brightness=1

# Main handler function
mpv_handler() {
  local event="$1"

  # Update MPV active status
  if [[ "$event" =~ ^activewindow\>\> ]]; then
    # Update MPV active status
    if [[ "$event" =~ ^activewindow\>\>mpv ]]; then
      if [[ $is_mpv_fullscreen -eq 1 ]]; then
        fullscreened
      fi
      is_mpv_active=1
    else
      if [[ $is_mpv_active -eq 1 && $is_mpv_fullscreen -eq 1 ]]; then
        unfullscreened
      fi
      is_mpv_active=0
    fi
  fi

  # Handle fullscreen state changes only when mpv is active
  if [[ "$event" =~ ^fullscreen\>\> && $is_mpv_active -eq 1 ]]; then
    if [[ "$event" =~ ^fullscreen\>\>1 ]]; then
      is_mpv_fullscreen=1
      fullscreened
    elif [[ "$event" =~ ^fullscreen\>\>0 ]]; then
      is_mpv_fullscreen=0
      unfullscreened
    fi
  fi
}

fullscreened() {
  "$(dirname "$0")/touchpad-toggle.sh" false >/dev/null
  backlight_brightness=$(brightnessctl --device="$backlight_device" --machine-readable get)
  brightnessctl --save --device="$backlight_device" set 0 >/dev/null
}

unfullscreened() {
  "$(dirname "$0")/touchpad-toggle.sh" true >/dev/null
  brightnessctl --device="$backlight_device" set "$backlight_brightness" >/dev/null
}

# Connect to Hyprland socket and process events
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
  mpv_handler "$line"
done
