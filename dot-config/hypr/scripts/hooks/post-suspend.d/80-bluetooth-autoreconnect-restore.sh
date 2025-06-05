#!/usr/bin/env sh

IFS='
'

LOG_PATH="$XDG_RUNTIME_DIR/bluetooth-autoreconnect"
LOG_FILE="$LOG_PATH/devices"

mkdir -p "$LOG_PATH"

icons_path="$HOME/.config/dunst/icons"

# Wait till bluetooth controller is back online
while [ -z "$(bluetoothctl list)" ]; do sleep 1; done

if [ -f "$LOG_FILE" ]; then
  devices=$(cat "$LOG_FILE")
  for device in $devices; do
    bluetoothctl connect "$(echo "$device" | awk '{print $2}')" &&
      notify-send --icon="$icons_path"/bluetooth/bluetooth-symbolic.svg -a bluetoothctl "Reconnected to $(echo "$device" | cut -d " " -f 3-)"
  done

  rm "$LOG_FILE"
fi
