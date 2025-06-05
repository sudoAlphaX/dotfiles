#!/usr/bin/env sh

if [ "$(playerctl status)" = "Playing" ]; then
  echo " $(playerctl metadata --format '{{title}} - {{artist}}')"
fi
