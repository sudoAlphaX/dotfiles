window=$(hyprctl activewindow -j)
window_id=$(echo "$window" | jq -r .address | sed 's/^0x//g')

notify-send -a "Hyprland" "Locking screen on window: $(echo "$window" | jq -r ".class")"

function windowlock_handler {

  local event="$1"

  if [[ "$event" =~ ^activewindowv2\>\> ]]; then
    if [[ "$event" != "activewindowv2>>$window_id" ]]; then
      loginctl lock-session
      pkill -P $$ socat
      exit 0
    fi
  fi

}

socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do windowlock_handler "$line"; done
