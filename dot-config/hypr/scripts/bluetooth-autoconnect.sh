#!/usr/bin/env sh

echo "Starting $(basename "$0")" "$@"

IFS='
'

icons_path="$HOME/.config/dunst/icons"

# Wait till bluetooth controller is online
while [ -z "$(bluetoothctl list)" ]; do sleep 1; done

devices=$(bluetoothctl devices Trusted)

for device in $devices; do
  echo "Attempting autoconnect for $device"
  bluetoothctl connect "$(echo "$device" | awk '{print $2}')" && notify-send --icon="$icons_path"/bluetooth/bluetooth-symbolic.svg -a bluetoothctl "Autoconnected to $(echo "$device" | cut -d " " -f 3-)" && break
done

exit 0
