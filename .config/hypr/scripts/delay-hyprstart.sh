#!/usr/bin/env sh

while true; do
  if hyprctl version 2>/dev/null | grep -q "^Hyprland"; then
    break
  fi
  sleep 1
done

sleep 1
