if [[ $(tty) = "/dev/tty1" || $(tty) = "/dev/tty2" ]]; then
  if uwsm check may-start 1 2; then
    if nm-online -q -t 0 && ping -q -c 1 -w 2 github.com >/dev/null; then
      echo "Pulling dotfiles"
      git -C "$HOME/.dotfiles/" pull --autostash
    fi
    exec uwsm start hyprland.desktop
  fi
fi
