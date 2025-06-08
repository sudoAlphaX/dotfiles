# Tmux on SSH (https://stackoverflow.com/a/40192494)
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
  tmux attach-session -t ssh || tmux new-session -s ssh
  exit # close the shell if tmux is detached/closed
fi

# p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source zsh-autocomplete
skip_global_compinit=1
source $ZSH_CUSTOM/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

##### omz configuration #####

# Theme (p10k)
ZSH_THEME="powerlevel10k/powerlevel10k"

# Disable automatic updates
zstyle ':omz:update' mode disabled

# Show loading prompt
COMPLETION_WAITING_DOTS=false

# Case insensitive match
CASE_SENSITIVE=false

# Use hyphen and underscore interchangably
HYPHEN_INSENSITIVE=true

# Pasting urls magic functions
DISABLE_MAGIC_FUNCTIONS=false

# Command correction
ENABLE_CORRECTION=true

# Mark untracked files as dirty (for speed in large repositories)
# DISABLE_UNTRACKED_FILES_DIRTY=true

# History
HIST_STAMPS="yyyy-mm-dd"

##### END omz configuration #####

##### omz plugins configuration #####
plugins=()

# als command to view aliases
plugins+=(aliases)

# Show when shortcuts are available
# plugins+=(alias-finder)
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer no
zstyle ':omz:plugins:alias-finder' exact no
zstyle ':omz:plugins:alias-finder' cheaper yes

# Notify when background jobs finish
plugins+=(bgnotify)
bgnotify_bell=true
bgnotify_threshold=300
bgnotify_extraargs="-a zsh -u low"
function bgnotify_formatted {
  ## $1=exit_status, $2=command, $3=elapsed_time

  local ignore=(
    "lazygit"
    "nvim"
    "vim"
    "nano"
    "less"
    "man"
    "more"
    "yt-x"
    "fastanime"
    "btop"
    "htop"
    "top"
    "iotop"
    "battop"
    "nvimconf"
    "zshconf"
    "zsh"
    "bash"
    "sh"
    "isd"
    "journalctl"
    "systemctl-tui"
    "watch"
    "python"
    "python3"
    "tmux"
    "sleep"
    "mpv"
    "ytfzf"
    "ssh"
    "topgrade"
  )

  program=$(echo $2 | awk '{print $1}')

  if [[ "${ignore[@]}" =~ "$program" ]]; then
    return
  fi

  # Humanly readable elapsed time
  local elapsed="$(( $3 % 60 ))s"
  (( $3 < 60 ))   || elapsed="$((( $3 % 3600) / 60 ))m $elapsed"
  (( $3 < 3600 )) || elapsed="$((  $3 / 3600 ))h $elapsed"

  if [[ $1 -eq 0 ]]; then
    local bg_status="completed"
  else
    local bg_status="failed"
  fi

  bgnotify "$program ${bg_status} - took ${elapsed} - $2"
}

# pkgfile command-not-found
plugins+=(command-not-found)

# Use <C-o> to copy current command to clipboard
plugins+=(copybuffer)

# Use <C-z> to fg suspended job
plugins+=(fancy-ctrl-z)

# Git
plugins+=(git gitignore git-auto-fetch)

# Use <ESC>+man or <ESC>+tldr to see prev command help
plugins+=(man tldr)

# Prevent running pasted commands
plugins+=(safe-paste)

# Use <ESC><ESC> to prefix command with sudo
plugins+=(sudo)

# Archive utilities
plugins+=(extract universalarchive)

# Auto activate python virtualenv
plugins+=(virtualenvwrapper)

# Z
plugins+=(z)

#### END omz plugins configuration #####


# LS_COLORS
export LS_COLORS="$(vivid generate catppuccin-mocha)"

# Sourcing
source $ZSH/oh-my-zsh.sh
source $ZSH_CUSTOM/themes/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $ZDOTDIR/.zshalias

##### zsh-autocomplete configuration #####

zstyle ':completion:*' completer _complete _complete:-fuzzy _correct _approximate _ignored

# Make Tab and ShiftTab go to the menu
bindkey '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select

# Make Tab and ShiftTab change the selection in the menu
bindkey -M menuselect '^I' menu-complete
bindkey -M menuselect "$terminfo[kcbt]" reverse-menu-complete

bindkey '^[OA' history-search-backward

##### END zsh-autocomplete configuration #####

# Initialize p10k prompt
[[ ! -f ${ZDOTDIR:-~}/.p10k.zsh ]] || source ${ZDOTDIR:-~}/.p10k.zsh
