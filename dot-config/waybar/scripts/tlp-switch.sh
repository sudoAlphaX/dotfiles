#!/usr/bin/env sh

# Toggle TLP power profile from a Waybar click.
#
# Usage: ./script left    (bind to left  click)
#        ./script right   (bind to right click)
#
# Left  click: power-saver <-> balanced
# Right click: performance <-> balanced

set -euo

action="${1:-}"

# Read current profile and normalise it to a bare keyword.
current="$(tlpctl get)"
case "$current" in
*power-saver*) current="power-saver" ;;
*performance*) current="performance" ;;
*balanced*) current="balanced" ;;
*)
  echo "Unknown profile from 'tlpctl get': $current" >&2
  exit 1
  ;;
esac

# Decide the target profile.
case "$action" in
right)
  if [ "$current" = "power-saver" ]; then
    target="balanced"
  else
    target="power-saver"
  fi
  ;;
left)
  if [ "$current" = "performance" ]; then
    target="balanced"
  else
    target="performance"
  fi
  ;;
*)
  echo "Usage: $0 {left|right}" >&2
  exit 1
  ;;
esac

tlpctl "$target"
