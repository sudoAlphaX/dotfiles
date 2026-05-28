#!/usr/bin/env sh

key='."k10temp-pci-00c3".Tctl.temp1_input'

temp="$(sensors -j | jq -r "$key | floor")"

# Temperature thresholds
criticalTemp=85
highTemp=60

if [ "$temp" -ge "$criticalTemp" ]; then
  tempState="critical"
elif [ "$temp" -ge "$highTemp" ]; then
  tempState="high"
else
  tempState="normal"
fi

printf '{"text": "%s", "class": "%s"}\n' "$temp" "$tempState"
