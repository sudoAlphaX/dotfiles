#!/bin/bash

pid=$(pidof wf-recorder)

if [ "$pid" ]; then
	# Stop screen recording
	for id in $pid; do 
		while kill -INT $id; do
			sleep 1
		done
	done
	
	pactl unload-module module-loopback
	pactl unload-module module-null-sink

	stray=$(pidof wf-recorder)
	if [ $stray ]; then
		for id in $stray; do (kill -9 $id); done
	fi

	exit 0
fi


declare -a monitors

for source in $(pactl list sources | grep Name | grep monitor | sed 's/Name: //g'); do
	monitors+=("$source")
done


pactl load-module module-null-sink sink_name=combined

for source in "${monitors[@]}"; do 
	pactl load-module module-loopback sink=combined source=$source
done

filename="$(xdg-user-dir VIDEOS)/wf-recorder/$(date +%Y%m%d_%H%M%S)_$(hyprctl activewindow -j | jq -r .class).mp4"


wf-recorder --audio=combined.monitor -f $filename -c h264_vaapi -d /dev/dri/renderD128
