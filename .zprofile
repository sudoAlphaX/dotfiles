if [[ $(tty) = "/dev/tty1" || $(tty) = "/dev/tty2" ]] then; exec Hyprland >> "/tmp/hyprlog-$(whoami).txt"; exit; fi
