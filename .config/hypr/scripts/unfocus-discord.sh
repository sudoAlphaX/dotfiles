# Script to unfocus Discord and focus the last focused application
# To be executed on Hyprland startup

# Wait until discord is the focused application
until [ "$(hyprctl activewindow -j | jq .initialTitle -r)" = "Discord" ]; do sleep 0.1; done
hyprctl dispatch focuscurrentorlast
