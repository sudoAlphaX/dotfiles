#!/usr/bin/sh
# Watches the ACPI platform profile (set by TLP) and runs the matching hook dir.
# The profile string from the kernel IS the dir name: performance / balanced / low-power.
FILE="/sys/firmware/acpi/platform_profile"
HOOKS="$(dirname "$0")"

if [ ! -r "$FILE" ]; then
  echo "Cannot read $FILE" >&2
  exit 1
fi

# The leading `echo` primes the loop so the current profile applies once at startup
# (inotifywait only reports *changes*); after that it's one line per modify event.
last=""
{
  inotifywait -q -m -e modify --format '%e' "$FILE"
} | while read -r _; do
  profile=$(cat "$FILE")
  if [ "$profile" = "$last" ]; then
    continue # sysfs can emit repeat modify events for one change
  fi
  last="$profile"

  DIR="$HOOKS/platform-profile-$profile.d"
  if [ -d "$DIR" ]; then
    for script in "$DIR"/*; do
      if [ -x "$script" ]; then
        echo "Running $profile hook: $(basename "$script")"
        "$script"
      fi
    done
  fi
done
