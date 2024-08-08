if [[ $(tty) == "/dev/tty1" ]] then; exec Hyprland >> /tmp/hyprlog.txt; exit; fi
