#!/bin/bash

STATUS_FILE=/tmp/touchscreen.log

enable_touchscreen() {
  hyprctl keyword -r '$TOUCHSCREEN_ENABLED' "true"
  echo "true" >"$STATUS_FILE"
  notify-send --category=device --urgency=low "touchscreen Enabled"
}

disable_touchscreen() {
  hyprctl keyword -r '$TOUCHSCREEN_ENABLED' "false"
  echo "false" >"$STATUS_FILE"
  notify-send --category=device --urgency=low "touchscreen Disabled"
}

if [ ! -f "$STATUS_FILE" ]; then
  disable_touchscreen
else
  if [ "$(cat "$STATUS_FILE")" = 'true' ]; then
    disable_touchscreen
  else
    enable_touchscreen
  fi
fi
