#!/usr/bin/env sh

icon=""
output="$(playerctl metadata --format '{{status}}:{{playerName}}:{{artist}}:{{album}}:{{title}}')" 2>/dev/null

status="$(echo "$output" | cut -d':' -f1)"

if [ "$status" != "Playing" ]; then
  exit 1
fi

artist="$(echo "$output" | cut -d':' -f3)"
title="$(echo "$output" | cut -d':' -f5- | sed 's/\.*$//')"

echo "$icon $title - $artist"
