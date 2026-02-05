# umask setting
umask 0027

# XDG config variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Path to zsh configuration directory
export HISTFILE="$XDG_STATE_HOME/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

# Path to oh-my-zsh installation.
export ZSH="$ZDOTDIR/assets/ohmyzsh/"
export ZSH_CUSTOM="$ZDOTDIR/assets/custom"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"

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
export PATH="$HOME/.local/bin:$PATH"

# Libvirt use system scope
export LIBVIRT_DEFAULT_URI="qemu:///system"

# Lazygit use theme with different config
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/mauve.yml"

# Systemd disable pager
export SYSTEMD_PAGER="cat"

# Chrome(ium) executable (for Flutter web)
export CHROME_EXECUTABLE="$(where chromium | head -n 1)"

################ xdg-ninja $HOME cleanup ################

# .wakatime
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"

# .android
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
export ANDROID_HOME="$ANDROID_USER_HOME/sdk"
alias adb='HOME="$ANDROID_USER_HOME" adb'

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

# .texlive
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var

# .gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

# .rustup
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

# .azure
export AZURE_CONFIG_DIR="$XDG_DATA_HOME"/azure

# .docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

# .lesshst
export LESSHISTFILE="${XDG_STATE_HOME}"/lesshst

# .npm
export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm

# .sqlite_history
export SQLITE_HISTORY="$XDG_CACHE_HOME"/sqlite_history

# .psql_history
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"

# .wine
export WINEPREFIX="$XDG_DATA_HOME"/wine

# .dotnet
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
