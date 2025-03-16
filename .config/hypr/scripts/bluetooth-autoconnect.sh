#!/usr/bin/env sh

IFS='
'

devices=$(bluetoothctl devices Trusted)

for device in $devices; do
  bluetoothctl connect "$(echo "$device" | cut -d " " -f 2)" && notify-send -i bluetooth-symbolic -a bluetoothctl "Autoconnected to $(echo "$device" | cut -d " " -f 3)" && break
done
