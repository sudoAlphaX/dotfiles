#!/usr/bin/sh

icons_path="$HOME/.config/dunst/icons"

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d?\d?\d%' | tail --lines=1 | sed 's/%//g')

if [ "$(pactl get-sink-mute @DEFAULT_SINK@ | cut -d ' ' -f 2)" = 'yes' ]; then
  notify-send --category=device --urgency=low --icon="$icons_path"/audio/audio-volume-muted-symbolic.svg --expire-time 3000 --hint=int:value:"$volume" mute_event
else
  notify-send --category=device --urgency=low --icon="$icons_path"/audio/audio-volume-overamplified-symbolic.svg --expire-time 3000 --hint=int:value:"$volume" volume_event
fi
