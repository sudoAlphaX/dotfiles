#!/bin/bash

path=$1

if [[ -z "$path" ]]; then
	echo "Path not specified. Exiting..."
	exit 1
else
	rawTemp=$(cat "$path"/hwmon[[:print:]]*/temp1_input)
	temp=${rawTemp::-3}

	criticalTemp=68
	highTemp=60

	if (( $temp >= $criticalTemp )); then
		tempState="critical"
	elif (( $temp >= $highTemp )); then
		tempState="high"
	else
		tempState="normal"
	fi

	printf '{"text": "%s", "class": "%s"}\n' "$temp" "$tempState"

fi
