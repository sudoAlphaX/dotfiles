__replace-buffer() {
  local old=$1 new=$2 space=${2:+ }

  # if the cursor is positioned in the $old part of the text, make
  # the substitution and leave the cursor after the $new text
  if [[ $CURSOR -le ${#old} ]]; then
    BUFFER="${new}${space}${BUFFER#$old }"
    CURSOR=${#new}
  # otherwise just replace $old with $new in the text before the cursor
  else
    LBUFFER="${new}${space}${LBUFFER#$old }"
  fi
}

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo/sudo.plugin.zsh
# <ESC><ESC> to toggle ele (elevated) for the current command
ele-command-line() {
  # If line is empty, get the last run command from history
  [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"

  # Save beginning space
  local WHITESPACE=""
  if [[ ${LBUFFER:0:1} = " " ]]; then
    WHITESPACE=" "
    LBUFFER="${LBUFFER:1}"
  fi

  {
    # If $SUDO_EDITOR or $VISUAL are defined, then use that as $EDITOR
    # Else use the default $EDITOR
    local EDITOR=${SUDO_EDITOR:-${VISUAL:-$EDITOR}}

    # If $EDITOR is not set, just toggle the sudo prefix on and off
    if [[ -z "$EDITOR" ]]; then
      case "$BUFFER" in
        eledit\ *) __replace-buffer "eledit" "" ;;
        ele\ *) __replace-buffer "ele" "" ;;
        *) LBUFFER="ele $LBUFFER" ;;
      esac
      return
    fi

    # Check if the typed command is really an alias to $EDITOR

    # Get the first part of the typed command
    local cmd="${${(Az)BUFFER}[1]}"
    # Get the first part of the alias of the same name as $cmd, or $cmd if no alias matches
    local realcmd="${${(Az)aliases[$cmd]}[1]:-$cmd}"
    # Get the first part of the $EDITOR command ($EDITOR may have arguments after it)
    local editorcmd="${${(Az)EDITOR}[1]}"
    if [[ "$realcmd" = (\$EDITOR|$editorcmd|${editorcmd:c}) \
      || "${realcmd:c}" = ($editorcmd|${editorcmd:c}) ]] \
      || builtin which -a "$realcmd" | command grep -Fx -q "$editorcmd"; then
      __replace-buffer "$cmd" "eledit"
      return
    fi

    # Check for editor commands in the typed command and replace accordingly
    case "$BUFFER" in
      $editorcmd\ *) __replace-buffer "$editorcmd" "eledit" ;;
      \$EDITOR\ *) __replace-buffer '$EDITOR' "eledit" ;;
      eledit\ *) __replace-buffer "eledit" "$EDITOR" ;;
      ele\ *) __replace-buffer "ele" "" ;;
      *) LBUFFER="ele $LBUFFER" ;;
    esac
  } always {
    # Preserve beginning space
    LBUFFER="${WHITESPACE}${LBUFFER}"

    # Redisplay edit buffer (compatibility with zsh-syntax-highlighting)
    zle && zle redisplay # only run redisplay if zle is enabled
  }
}

zle -N ele-command-line

# Defined shortcut keys: [Esc] [Esc]
bindkey -M emacs '\e\e' ele-command-line
bindkey -M vicmd '\e\e' ele-command-line
bindkey -M viins '\e\e' ele-command-line

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo/sudo.plugin.zsh
# <ESC>mx to move current command to tmux session
tmux-command-line() {
  # If line is empty, get the last run command from history
  [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"

  # Save beginning space
  local WHITESPACE=""
  if [[ ${LBUFFER:0:1} = " " ]]; then
    WHITESPACE=" "
    LBUFFER="${LBUFFER:1}"
  fi

  {
    # Simple tmux toggle functionality
    case "$BUFFER" in
      tmux\ new-session\ *) __replace-buffer "tmux new-session" "" ;;
      *) LBUFFER="tmux new-session $LBUFFER" ;;
    esac
  } always {
    # Preserve beginning space
    LBUFFER="${WHITESPACE}${LBUFFER}"

    # Redisplay edit buffer (compatibility with zsh-syntax-highlighting)
    zle && zle redisplay # only run redisplay if zle is enabled
  }
}
zle -N tmux-command-line
bindkey "\e"mx tmux-command-line

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo/sudo.plugin.zsh
# <ESC>fj to toggle firejail --noprofile for the current command
firejail-noprofile-command-line() {
  # If line is empty, get the last run command from history
  [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"

  # Save beginning space
  local WHITESPACE=""
  if [[ ${LBUFFER:0:1} = " " ]]; then
    WHITESPACE=" "
    LBUFFER="${LBUFFER:1}"
  fi

  {
    # Simple firejail --noprofile toggle functionality
    case "$BUFFER" in
      firejail\ --noprofile\ *) __replace-buffer "firejail --noprofile" "" ;;
      *) LBUFFER="firejail --noprofile $LBUFFER" ;;
    esac
  } always {
    # Preserve beginning space
    LBUFFER="${WHITESPACE}${LBUFFER}"

    # Redisplay edit buffer (compatibility with zsh-syntax-highlighting)
    zle && zle redisplay # only run redisplay if zle is enabled
  }
}
zle -N firejail-noprofile-command-line
bindkey "\e"fj firejail-noprofile-command-line

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo/sudo.plugin.zsh
# <ESC>px to toggle proxychains for the current command
proxychains-command-line() {
  # If line is empty, get the last run command from history
  [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"

  # Save beginning space
  local WHITESPACE=""
  if [[ ${LBUFFER:0:1} = " " ]]; then
    WHITESPACE=" "
    LBUFFER="${LBUFFER:1}"
  fi

  {
    # Simple proxychains toggle functionality
    case "$BUFFER" in
      proxychains\ *) __replace-buffer "proxychains" "" ;;
      *) LBUFFER="proxychains $LBUFFER" ;;
    esac
  } always {
    # Preserve beginning space
    LBUFFER="${WHITESPACE}${LBUFFER}"

    # Redisplay edit buffer (compatibility with zsh-syntax-highlighting)
    zle && zle redisplay # only run redisplay if zle is enabled
  }
}
zle -N proxychains-command-line
bindkey "\e"px proxychains-command-line

