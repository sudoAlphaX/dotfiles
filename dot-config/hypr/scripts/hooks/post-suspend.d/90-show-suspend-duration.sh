#!/usr/bin/env sh

current_time=$(date +%s)

if [ ! -f "$XDG_RUNTIME_DIR"/suspend_timestamp ]; then
  echo "Suspend timestamp file not found. Exiting." >&2
  exit 1
else
  past_time=$(cat "$XDG_RUNTIME_DIR"/suspend_timestamp)
fi

notify-send -a hypridle "Suspended for: " "$(timediff $((current_time - past_time)))"
