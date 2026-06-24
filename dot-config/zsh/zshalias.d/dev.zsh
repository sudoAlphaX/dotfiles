function dev() {
  # logger
  local _c_reset=$'\e[0m' _c_dim=$'\e[2m' _c_blue=$'\e[34m' _c_grn=$'\e[32m' _c_red=$'\e[31m'
  [[ -t 2 ]] || { _c_reset= _c_dim= _c_blue= _c_grn= _c_red=; }
  local log() { print -u2 -r -- "${_c_blue}dev❯${_c_reset} $*"; }
  local warn() { print -u2 -r -- "${_c_red}dev❯${_c_reset} $*"; }

  local src
  if src=$(git rev-parse --show-toplevel 2>/dev/null); then
    log "git repo root: ${_c_dim}${src}${_c_reset}"
  else
    src=$PWD
    log "not a git repo, using cwd: ${_c_dim}${src}${_c_reset}"
  fi

  # The bind mounted directory is the top level dir of the git repo if I am in one
  # Or the current directory

  src=${src:A}                       # realpath + resolve symlinks
  local name=${src:t}
  local dst=/home/dev/$name

  # Unique name derived from the path to prevent duplicates
  # readable, deterministic name from the full path
  local esc; esc=$(systemd-escape -p -- "$src")
  esc=${esc//\\x[0-9a-f][0-9a-f]/-}                # collapse \xNN escapes to '-'
  local mname="dev-${esc}"
  (( ${#mname} > 64 )) && { mname=${mname[1,64]}; warn "name truncated to 64 chars"; }

  local link=/run/systemd/nspawn/${mname}.nspawn

  log "machine: ${_c_grn}${mname}${_c_reset}"


  if sudo machinectl status "$mname" &>/dev/null; then
    log "already running"
  else
    log "mount: ${src} ${_c_dim}->${_c_reset} ${dst} ${_c_dim}(idmap)${_c_reset}"
    log "starting ephemeral container"
    sudo systemctl reset-failed "$mname" 2>/dev/null
    sudo mkdir -p /run/systemd/nspawn

    # per-machine settings = dev.nspawn + extra bind (CLI --bind loses to
    # the file's Bind= under --settings=override, so put it in the file too)
    sudo cp /etc/systemd/nspawn/dev.nspawn "$link"
    printf '\n[Files]\nBind=%s:%s:idmap\n' "$src" "$dst" | sudo tee -a "$link" >/dev/null

    # Using systemd-run because machinectl will recognize the machine only if the directory exists in /var/lib/machines/$mname
    # We dont have that because we are using an ephemeral machine with a different name
    # We need to boot this first, then use machinectl for management like opening a shell, or restarting, or poweroff.
    # systemd-run just replicated what machinectl start, but for the case where /var/lib/machines/<dir> doesnt exist
    if ! sudo systemd-run --unit="$mname" --collect --property=Delegate=yes -- \
        /usr/bin/systemd-nspawn \
          --keep-unit \
          --machine="$mname" \
          --directory=/var/lib/machines/dev \
          --ephemeral \
          --settings=override \
          ; then
      warn "failed to start ${mname}"
      sudo rm -f "$link"
      return 1
    fi

    log "booting"
    local -i waited=0
    until [[ $(sudo systemctl --machine="$mname" is-system-running 2>/dev/null) == (running|degraded) ]]; do
      sleep 1
      if (( ++waited > 30 )); then      # ~30s
        warn "timed out waiting for boot"
        return 1
      fi
    done
    log "ready"
  fi

  log "opening tmux in ${dst}"
  sudo machinectl shell dev@"$mname" \
    /bin/sh -c "cd ${(q)dst} && exec /usr/bin/tmux"
}
