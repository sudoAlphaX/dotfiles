if [[ $(tty) = "/dev/tty1" || $(tty) = "/dev/tty2" ]] then
  if uwsm check may-start; then
      exec uwsm start hyprland.desktop
  fi
fi
