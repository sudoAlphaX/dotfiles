#!/usr/bin/bash

pid=$(pidof wf-recorder)

if [ "$pid" ]; then
  # Stop screen recording
  for id in $pid; do
    while kill -SIGINT "$id"; do
      sleep 1
    done
  done

  exit 0
fi

declare -a monitors

for source in $(pactl list sources | grep Name | grep monitor | sed 's/Name: //g'); do
  monitors+=("$source")
done

pactl load-module module-null-sink sink_name=combined

for source in "${monitors[@]}"; do
  pactl load-module module-loopback sink=combined source="$source"
done

mkdir -p "$HOME/Videos/wf-recorder/tmp"
mkdir -p "$XDG_RUNTIME_DIR/wf-recorder-thumbnails"

filename="$(date +%Y%m%d_%H%M%S)_$(hyprctl activewindow -j | jq -r .class).mp4"
filepath="$HOME/Videos/wf-recorder$(if [ "$1" != "false" ]; then echo "/tmp"; fi)/$filename"
thumbnail="/$XDG_RUNTIME_DIR/wf-recorder-thumbnails/$filename.png"

if [ "$2" = "true" ]; then
  wf-recorder -g "$(slurp)" --audio=combined.monitor -f "$filepath" -r 30 -c h264_vaapi -d /dev/dri/renderD128
else
  wf-recorder --audio=combined.monitor -f "$filepath" -r 30 -c h264_vaapi -d /dev/dri/renderD128
fi

pactl unload-module module-loopback
pactl unload-module module-null-sink

ffmpegthumbnailer -i "$filepath" -o "$thumbnail" -s 0

if [ "$1" != "false" ]; then
  wl-copy "file://$filepath" --type "text/uri-list"
  notify-send -u low -a wf-recorder -i "$thumbnail" "Copied screen recording to clipboard"
else
  notify-send -u low -a wf-recorder -i "$thumbnail" "Saved screen recording to $filename"
fi
