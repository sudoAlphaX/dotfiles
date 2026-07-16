#!/usr/bin/sh

pactl set-sink-mute "$(pactl get-default-sink)" true
