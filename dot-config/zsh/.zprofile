# Autostart ssh-agent
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent)" >/dev/null
fi

# Dotfiles auto-update
dotfiles_path="$HOME/.dotfiles"

if [[ $(tty) = "/dev/tty1" || $(tty) = "/dev/tty2" ]]; then
  if uwsm check may-start 1 2; then
    remote=$(git -C "$dotfiles_path" remote get-url origin 2>/dev/null)

    # Stupid solution... I know. I should have used git ls-remote. But I've already coded it and don't want to change it now.
    if ( (echo "$remote" | grep -qE '^(http|https|ssh)://') && nm-online -q -t 0 && ping -q -c 1 -w 2 github.com >/dev/null) ||
      [[ -d "$remote/.git" ]]; then
      echo "Updating dotfiles..."
      git -C "$dotfiles_path" pull --autostash
    else
      echo "Remote repository not found, skipping pull."
    fi
    exec uwsm start hyprland.desktop
  fi
fi
