#!/usr/bin/env sh

LOG_PATH="$XDG_RUNTIME_DIR/bluetooth-autoreconnect"
LOG_FILE="$LOG_PATH/devices"

mkdir -p "$LOG_PATH"

devices=$(bluetoothctl devices Connected)
if [ -n "$devices" ]; then
  echo "$LOG_FILE"
  echo "$devices" >"$LOG_FILE"
fi
