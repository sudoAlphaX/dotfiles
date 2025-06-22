#!/usr/bin/env sh

pactl set-sink-mute "$(pactl get-default-sink)" true
