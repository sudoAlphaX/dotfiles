#!/bin/sh

ICON="󰧑 "

if [ "$1" = "--kill" ]; then
  curl -s "$OLLAMA_API_BASE/api/ps" |
    jq -r '.models[].name' |
    while IFS= read -r m; do
      [ -n "$m" ] && ollama stop "$m"
    done
  exit 0
fi

curl -s "$OLLAMA_API_BASE/api/ps" | jq -c --arg icon "$ICON" '
  if (.models | length) == 0 then
    empty
  else
    {
      text: ($icon + ([.models[].name] | join(" | "))),
      tooltip: ([.models[]
        | "Model: \(.model)\nParameter size:\(.details.parameter_size)"]
        | join("\n\n"))
    }
  end
'
