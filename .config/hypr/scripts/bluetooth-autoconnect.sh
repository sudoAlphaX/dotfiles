#!/usr/bin/env sh

IFS='
'

icons_path="$HOME/.config/dunst/icons"

devices=$(bluetoothctl devices Trusted)

for device in $devices; do
  bluetoothctl connect "$(echo "$device" | cut -d " " -f 2)" && notify-send --icon="$icons_path"/bluetooth/bluetooth-symbolic.svg -symbolic -a bluetoothctl "Autoconnected to $(echo "$device" | cut -d " " -f 3)" && break
done
