#!/usr/bin/bash

path=$1

if [[ -z "$path" ]]; then
  echo "Path not specified. Exiting..."
  exit 1
else
  rawTemp=$(cat "$path"/hwmon[[:print:]]*/temp1_input)
  temp=${rawTemp::-3}

  notifyCriticalTemp=75
  criticalTemp=68
  highTemp=60

  if ((temp >= notifyCriticalTemp)); then
    tempState="critical"
    notify-send -u critical -h int:value:"$temp" --category=device temperature_critical_event
  elif ((temp >= criticalTemp)); then
    tempState="critical"
  elif ((temp >= highTemp)); then
    tempState="high"
  else
    tempState="normal"
  fi

  printf '{"text": "%s", "class": "%s", "tooltip": "%s RPM"}\n' "$temp" "$tempState" "$(cat /sys/devices/platform/dell_smm_hwmon/hwmon/hwmon[[:print:]]*/fan1_input)"

fi
