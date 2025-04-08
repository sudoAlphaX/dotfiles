#!/usr/bin/sh

STATUS_FILE=$XDG_RUNTIME_DIR/touchpad-status
device="dll07d0:01-044e:120b"

enable_touchpad() {
  show_notification=${1:-true}
  hyprctl keyword "device[$device]:enabled" 1
  echo "true" >"$STATUS_FILE"
  if [ "$show_notification" = "true" ]; then
    notify-send --category=device --urgency=low "Touchpad Enabled"
  fi
}

disable_touchpad() {
  show_notification=${1:-true}
  hyprctl keyword "device[$device]:enabled" 0
  echo "false" >"$STATUS_FILE"
  if [ "$show_notification" = "true" ]; then
    notify-send --category=device --urgency=low "Touchpad Disabled"
  fi
}

toggle_touchpad() {
  if [ ! -f "${STATUS_FILE}" ] || [ "$(cat "${STATUS_FILE}")" = 'false' ]; then
    enable_touchpad
  else
    disable_touchpad
  fi
}

# Handle arguments
if [ $# -eq 0 ]; then
  toggle_touchpad
elif [ "$1" = "true" ]; then
  enable_touchpad false
elif [ "$1" = "false" ]; then
  disable_touchpad false
else
  echo "Error: Invalid argument. Use 'true', 'false', or no argument to toggle." >&2
  exit 1
fi
