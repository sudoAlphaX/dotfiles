# XDG config variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Path to zsh configuration directory
export HISTFILE="$XDG_STATE_HOME/zsh/history"

# Path to oh-my-zsh installation.
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"
export ZSH_CUSTOM="$XDG_CONFIG_HOME/omz-custom"

# Z plugin
export _Z_DATA="$XDG_DATA_HOME/z"

# Editor
export EDITOR="nvim"
export NVIM_APPNAME="nvim-lazyvim"

# nvim as MAN pager
export MANPAGER='nvim +Man!'

# Fix for gpg password prompt in tty
export GPG_TTY=$TTY

# Local binaries path
export PATH="$PATH:$HOME/.local/bin"


################ xdg-ninja $HOME cleanup ################

# .wakatime
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"

# .android
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android

# .cargo
export CARGO_HOME="$XDG_DATA_HOME"/cargo

# .go
export GOPATH="$XDG_DATA_HOME"/go

# .parallel
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel

# .w3m
export W3M_DIR="$XDG_DATA_HOME"/w3m

# .virtualenvs
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
