#/bin/bash

STATUS_FILE=touchpad.log

enable_touchpad() {
	hyprctl keyword -r '$TOUCHPAD_ENABLED' "true"
	echo "true" > $STATUS_FILE
	notify-send --category=device "Touchpad Enabled"
}

disable_touchpad() {
	hyprctl keyword -r '$TOUCHPAD_ENABLED' "false"
	echo "false" > $STATUS_FILE
	notify-send --category=device "Touchpad Disabled"
}

if [ ! -f $STATUS_FILE ]; then
	enable_touchpad
else
	if [ $(cat touchpad.log) = 'true' ]; then
		disable_touchpad
	else
		enable_touchpad
	fi
fi
