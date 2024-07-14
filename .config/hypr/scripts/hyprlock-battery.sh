capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

if (( capacity > 80 )); then
	batticon=" "
elif (( capacity > 60 )); then
	batticon=" "
elif (( capacity > 40 )); then
	batticon=" "
elif (( capacity > 20 )); then
	batticon=" "
else
	batticon=" "
fi

if [[ "$status" == "Charging" ]]; then
	icon=" $batticon"
elif [[ "$status" == "Discharging" ]]; then
	icon="$batticon"
elif [[ "$status" == "Not Charging" ]]; then
	icon="󰚦 $batticon"
elif [[ "status" == "Full" ]]; then
	icon=" $batticon"
else
	icon="$batticon"

echo $icon
