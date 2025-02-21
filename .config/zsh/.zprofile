if [[ $(tty) = "/dev/tty1" || $(tty) = "/dev/tty2" ]] then
  if uwsm check may-start 1 2; then
    if $(nm-online -q -t 5); then
      echo "Pulling dotfiles"
      git -C "$HOME/.dotfiles/" pull
    fi
    exec uwsm start hyprland.desktop
  fi
fi
