if [[ $(tty) = "/dev/tty1" || $(tty) = "/dev/tty2" ]] then; exec Hyprland; exit; fi
