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

if [ ! -f $STATUS_FILE ]; then
  disable_touchpad
else
  if [ "$(cat $STATUS_FILE)" = 'true' ]; then
    disable_touchpad
  else
    enable_touchpad
  fi
fi
