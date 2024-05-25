#!/bin/bash

path=$1

if [[ -z "$path" ]]; then
	echo "Path not specified. Exiting..."
	exit 1
else
	temp=$(cat "$path"/hwmon[[:print:]]*/temp1_input)
	echo "${temp::-3}" # remove last 3 characters
fi
