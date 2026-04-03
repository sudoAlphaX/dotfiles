#!/usr/bin/env sh

# Variables
server="brainfuel-server.ts.net"

if ! output="$(mcstatus "$server" json 2>/dev/null)" || [ -z "$output" ]; then
  printf '{"text": "󰍳 Error", "class": "critical", "tooltip": "Script error"}\n'
  exit 0
fi

online=$(echo "$output" | jq -r '.online')
players=$(echo "$output" | jq -r '.status.players.online // empty')
version=$(echo "$output" | jq -r '.status.version.name // empty')
motd=$(echo "$output" | jq -r '.status.motd // empty')
type=$(echo "$output" | jq -r '.kind // empty')
latency=$(printf '%.2f' "$(echo "$output" | jq -r '.status.latency // empty')")
players_list=$(echo "$output" | jq -r '.query.players.list // [] | .[]')

escape() {
  if [ -n "$1" ]; then
    echo "$1" | sed 's/"/\\"/g'
  else
    echo "???"
  fi
}

if [ "$online" = "false" ]; then
  printf '{"text": "󰍳 X", "class": "critical", "tooltip": "The server is offline."}\n'
  exit 0
elif [ "$players" = "0" ]; then
  players_display=" None"
  class="normal"
else
  class="normal"
  players_display=""
  while IFS= read -r name; do
    players_display="${players_display}\\n    ${name}"
  done <<EOF
$players_list
EOF
fi

tooltip="$(
  printf 'Type: %s' "$(escape "$type")"
  printf '\\nVersion: %s' "$(escape "$version")"
  printf '\\nLatency: %s' "$(escape "$latency")"
  printf '\\nMOTD: %s' "$(escape "$motd")"
  printf '\\nPlayers:%s' "$players_display"
)"

printf '{"text": "󰍳 %s", "class": "%s", "tooltip": "%s"}\n' \
  "$players" \
  "$class" \
  "$tooltip"
