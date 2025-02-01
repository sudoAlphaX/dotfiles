#!/usr/bin/sh

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d?\d?\d%' | tail --lines=1 | sed 's/%//g')

if [ "$(pactl get-sink-mute @DEFAULT_SINK@ | cut -d ' ' -f 2)" = 'yes' ]; then
  notify-send --category=device --urgency=low --icon=audio-volume-muted-symbolic --expire-time 3000 --hint=int:value:"$volume" mute_event
else
  notify-send --category=device --urgency=low --icon=audio-volume-medium-symbolic --expire-time 3000 --hint=int:value:"$volume" unmute_event
fi
