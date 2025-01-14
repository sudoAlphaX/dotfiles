#!/usr/bin/sh

if [ "$1" = 'r' ]; then
  hyprctl keyword -r '$transform' 1
elif [ "$1" = 'd' ]; then
  hyprctl keyword -r '$transform' 2
elif [ "$1" = 'l' ]; then
  hyprctl keyword -r '$transform' 3
elif [ "$1" = 'u' ]; then
  hyprctl keyword -r '$transform' 0
fi
