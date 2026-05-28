#!/usr/bin/env sh

# The file to monitor
FILE="/sys/firmware/acpi/platform_profile"

# Ensure the file exists before starting
if [ ! -r "$FILE" ]; then
  echo "Error: Cannot read $FILE" >&2
  exit 1
fi

# Monitor loop
inotifywait -q -m -e modify --format '%e' "$FILE" | while read -r event; do
  # Read the current profile
  PROFILE=$(cat "$FILE")

  notify-send --app-name=platform-profile --urgency=low "Power profile" "Current mode: $PROFILE"
done
