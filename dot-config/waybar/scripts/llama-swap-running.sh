#!/usr/bin/sh

ICON="󰧑 "
BASE="${LLAMA_SWAP_API_BASE:-http://127.0.0.1:11434}"

if [ "$1" = "--kill" ]; then
  curl -s -X POST "$BASE/api/models/unload" >/dev/null
  exit 0
fi

curl -s "$BASE/running" | jq -c --arg icon "$ICON" '
  if (.running | length) == 0 then
    empty
  else
    {
      text: ($icon + ([.running[].model] | join(" | "))),
      tooltip: ([.running[] | "Model: \(.model)\nState: \(.state)"] | join("\n\n"))
    }
  end
'
