#!/usr/bin/sh

enable_touchscreen() {
  hyprctl keyword input:touchdevice:enabled true
  notify-send --category=device --urgency=low "Touchscreen Enabled"
  echo "Touchscreen Enabled"
}

disable_touchscreen() {
  hyprctl keyword input:touchdevice:enabled false
  notify-send --category=device --urgency=low "Touchscreen Disabled"
  echo "Touchscreen Disabled"
}

if [ "$(hyprctl getoption -j input:touchdevice:enabled | jq .int)" = 0 ]; then
  enable_touchscreen
else
  disable_touchscreen
fi
