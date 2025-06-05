#!/usr/bin/sh

# Script to pass in called values to pactl set-volume (capped at 100%), with limits (to port -l flag in wpctl) unless @DEFAULT_SINK@ is alsa_output.pci-0000_00_1f.3.analog-stereo, in which case, it will only adjust right speaker's volume

sink=$(pactl get-default-sink)
increment_value="$1"
speaker_sink="alsa_output.pci-0000_00_1f.3.analog-stereo"
current_volume=$(pactl get-sink-volume "$sink" | grep -oP '\d?\d?\d%' | tail --lines=1 | sed 's/%//g') # Get the right speaker's volume

new_volume=$((current_volume + $1))
if [ "$new_volume" -gt 100 ]; then
  new_volume=100
  increment_value="+0"
fi

if [ "$sink" != $speaker_sink ]; then
  pactl set-sink-volume "$sink" "$increment_value"%
else
  pactl set-sink-volume "$sink" +0% "$increment_value"%
fi

echo $new_volume
