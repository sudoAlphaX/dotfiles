#!/usr/bin/sh

STATUS_FILE=$XDG_RUNTIME_DIR/touchpad-status

enable_touchpad() {
  hyprctl keyword -r '$TOUCHPAD_ENABLED' "true"
  echo "true" >$STATUS_FILE
  notify-send --category=device --urgency=low "Touchpad Enabled"
}

disable_touchpad() {
  hyprctl keyword -r '$TOUCHPAD_ENABLED' "false"
  echo "false" >$STATUS_FILE
  notify-send --category=device --urgency=low "Touchpad Disabled"
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
  enable_touchpad
elif [ "$1" = "false" ]; then
  disable_touchpad
else
  echo "Error: Invalid argument. Use 'true', 'false', or no argument to toggle." >&2
  exit 1
fi
