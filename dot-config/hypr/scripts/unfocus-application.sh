#!/usr/bin/sh

echo "Starting $(basename "$0")" "$@"

# Script to unfocus specified app (mostly autostarted) and focus the last focused application
# To be executed on Hyprland startup

# Wait until application is the focused
until [ "$(hyprctl activewindow -j | jq .initialClass -r)" = "$1" ]; do sleep 0.1; done
hyprctl dispatch focuscurrentorlast
