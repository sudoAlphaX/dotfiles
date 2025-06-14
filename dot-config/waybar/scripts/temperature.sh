#!/usr/bin/env sh

# Device paths
temp_path="/sys/devices/platform/coretemp.0/hwmon"
fan_path="/sys/devices/platform/dell_smm_hwmon/hwmon"

# Temperature thresholds
criticalTemp=70
highTemp=60

fan_speed=$(cat "$fan_path"/hwmon[[:print:]]*/fan1_input)

rawTemp=$(cat "$temp_path"/hwmon[[:print:]]*/temp1_input)
temp=$(echo "$rawTemp" | cut -c1-2)

if [ "$temp" -ge "$criticalTemp" ]; then
  tempState="critical"
elif [ "$temp" -ge "$highTemp" ]; then
  tempState="high"
else
  tempState="normal"
fi

printf '{"text": "%s", "class": "%s", "tooltip": "%s RPM"}\n' "$temp" "$tempState" "$fan_speed"
