#!/usr/bin/env sh

# Variables
max_length=30
dots_pos=17
icon=""

output="$(playerctl metadata --format '{{status}}:{{playerName}}:{{artist}}:{{album}}:{{title}}')" 2>/dev/null

status="$(echo "$output" | cut -d':' -f1)"

if [ "$status" != "Playing" ]; then
  exit 1
fi

escape() {
  if [ -n "$1" ]; then
    echo "$1" | sed 's/"/\\"/g'
  else
    echo "???"
  fi

}

player="$(echo "$output" | cut -d':' -f2)"
artist="$(echo "$output" | cut -d':' -f3)"
album="$(echo "$output" | cut -d':' -f4)"
title="$(echo "$output" | cut -d':' -f5- | sed 's/\.*$//')"

# echo " $(if [ "$(echo "$title" | wc -L)" -gt 25 ]; then echo "$(echo "$title" | cut -c1-13)...$(echo "$title" | rev | cut -c1-7 | rev)"; else echo "$title"; fi )"",

if [ "$(echo "$title" | wc -L)" -gt $max_length ]; then
  short_title="$(echo "$title" | cut -c1-"$dots_pos")...$(echo "$title" | rev | cut -c1-"$((max_length - dots_pos))" | rev)"
else
  short_title="$title"
fi

printf '{"text": "%s %s", "tooltip": "Title: %s%s"}\n' \
  "$icon" \
  "$(escape "$short_title")" \
  "$(escape "$title")" \
  "$(
    if [ -n "$artist" ]; then printf '\\nArtist: %s' "$(escape "$artist")"; fi
    if [ -n "$album" ]; then printf '\\nAlbum: %s' "$(escape "$album")"; fi
    if [ -n "$player" ]; then printf '\\nPlayer: %s' "$(escape "$player")"; fi
  )"
