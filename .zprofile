if [[ $(tty) == "/dev/tty1" ]] then; exec Hyprland >> "/tmp/hyprlog-$(whoami).txt"; exit; fi
