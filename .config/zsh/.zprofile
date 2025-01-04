if [[ $(tty) = "/dev/tty1" || $(tty) = "/dev/tty2" ]] then; exec Hyprland; loginctl kill-session self; fi
