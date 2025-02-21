#!/usr/bin/sh

STATUS_FILE=$XDG_RUNTIME_DIR/touchscreen-status

enable_touchscreen() {
  hyprctl keyword -r '$TOUCHSCREEN_ENABLED' "true"
  echo "true" >"$STATUS_FILE"
  notify-send --category=device --urgency=low "Touchscreen Enabled"
}

disable_touchscreen() {
  hyprctl keyword -r '$TOUCHSCREEN_ENABLED' "false"
  echo "false" >"$STATUS_FILE"
  notify-send --category=device --urgency=low "Touchscreen Disabled"
}

if [ ! -f "$STATUS_FILE" ]; then
  enable_touchscreen
else
  if [ "$(cat "$STATUS_FILE")" = 'true' ]; then
    disable_touchscreen
  else
    enable_touchscreen
  fi
fi
