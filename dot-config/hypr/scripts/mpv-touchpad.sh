#!/usr/bin/env bash

echo "Starting $(basename "$0")" "$@"

# Track mpv activewindow state
mpv_active=0
mpv_fullscreen=0
fullscreened_state=0

# Keyboard Backlight device
backlight_device="dell::kbd_backlight"
backlight_brightness=$(brightnessctl --device="$backlight_device" --machine-readable get)

# Script paths
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
TOUCHPAD_TOGGLE="${SCRIPT_DIR}/touchpad-toggle.sh"

# Main handler function
mpv_handler() {
  local event="$1"

  if [[ "$event" =~ ^activewindow\>\> ]]; then

    if [[ "$event" =~ ^activewindow\>\>mpv ]]; then
      mpv_active=1

      if [[ $fullscreened_state -eq 0 && $mpv_fullscreen -eq 1 ]]; then
        fullscreened
        fullscreened_state=1
      fi

    else
      mpv_active=0

      if [[ $fullscreened_state -eq 1 && $mpv_fullscreen -eq 1 ]]; then
        unfullscreened
        fullscreened_state=0
      fi

    fi

  elif [[ "$event" =~ ^fullscreen\>\> && $mpv_active -eq 1 ]]; then

    if [[ "$event" =~ ^fullscreen\>\>1 ]]; then
      mpv_fullscreen=1
      fullscreened
      fullscreened_state=1

    elif [[ "$event" =~ ^fullscreen\>\>0 ]]; then
      mpv_fullscreen=0
      unfullscreened
      fullscreened_state=0

    fi
  fi
}

fullscreened() {
  "$TOUCHPAD_TOGGLE" false >/dev/null 2>&1
  backlight_brightness=$(brightnessctl --device="$backlight_device" --machine-readable get)
  brightnessctl --save --device="$backlight_device" set 0 >/dev/null
  echo "MPV fullscreened"
}

unfullscreened() {
  "$TOUCHPAD_TOGGLE" true >/dev/null 2>&1
  "$(dirname "$0")/touchpad-toggle.sh" true >/dev/null
  brightnessctl --device="$backlight_device" set "$backlight_brightness" >/dev/null
  echo "MPV unfullscreened"
}

# Check if touchpad toggle exists
if [[ ! -x "$TOUCHPAD_TOGGLE" ]]; then
  echo "Error: $TOUCHPAD_TOGGLE not found or not executable" >&2
  exit 1
fi

# Connect to Hyprland socket and process events
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
  mpv_handler "$line"
done
