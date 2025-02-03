#!/usr/bin/sh

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d?\d?\d%' | tail --lines=1 | sed 's/%//g')

if [ "$(pactl get-sink-mute @DEFAULT_SINK@ | cut -d ' ' -f 2)" = 'yes' ]; then
  notify-send --category=device --urgency=low --icon=audio-volume-muted-symbolic --expire-time 3000 --hint=int:value:0 volume_event
else
  notify-send --category=device --urgency=low --icon=audio-volume-overamplified-symbolic --expire-time 3000 --hint=int:value:"$volume" volume_event
fi
