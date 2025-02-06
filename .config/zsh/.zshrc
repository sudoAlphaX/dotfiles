# zmodload zsh/zprof

# Tmux on SSH (https://stackoverflow.com/a/40192494)
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
  tmux attach-session -t ssh || tmux new-session -s ssh
  exit # close the shell if tmux is detached/closed
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k" # set by `omz`

# LS_COLORS
export LS_COLORS="$(vivid generate catppuccin-mocha)"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
#zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Plugin Configuration

# Tmux plugin
# if [[ $SSH_CONNECTION ]]; then 
# 	export ZSH_TMUX_AUTOSTART=true
# 	export ZSH_TMUX_AUTOQUIT=true
# 	export ZSH_TMUX_AUTONAME_SESSION='ssh'
# else
# 	export ZSH_TMUX_AUTOQUIT=false
# fi
#
# export ZSH_TMUX_CONFIG="$XDG_CONFIG_HOME/tmux/tmux.conf"

# Plugins
plugins=(sudo gpg-agent git gitignore git-auto-fetch aliases alias-finder arduino-cli colored-man-pages command-not-found extract universalarchive virtualenvwrapper z)
source $ZSH_CUSTOM/themes/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
# source $ZSH_CUSTOM/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Plugin Configuration

zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer no
zstyle ':omz:plugins:alias-finder' exact no
zstyle ':omz:plugins:alias-finder' cheaper yes

# ZSH_AUTOSUGGEST_STRATEGY=(completion match_prev_cmd)

# zsh-autocomplete plugin configuration
# Make Tab and ShiftTab go to the menu
bindkey '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select

# Make Tab and ShiftTab change the selection in the menu
bindkey -M menuselect '^I' menu-complete
bindkey -M menuselect "$terminfo[kcbt]" reverse-menu-complete

bindkey '^[OA' history-search-backward


############# Aliases #############

alias zshconf="nvim $ZDOTDIR/.zshrc"
alias tmuxconf="nvim $XDG_CONFIG_HOME/tmux/tmux.conf"

## a quick way to get out of current directory ##
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias .4="cd ../../../../"
alias .5="cd ../../../../.."

# Always copy contents of directories (r)ecursively and explain (v) what was done
# alias cp="cp -irv"
# rm command interactive
alias dl="rm -Iv"
alias del="rm -Iv"

# Create any non-existent (p)arent directories and explain (v) what was done
alias mkdir="mkdir -pv"

## Show hidden files ##
alias l.="ls -dlAF .* --color=auto"

## Colorize the grep command output for ease of use (good for log files)##
alias grep="grep --color=auto "

# Always try to (c)ontinue getting a partially-downloaded file and use XDG_DATA_HOME for wget-hsts file
alias wget="wget -c --hsts-file=\"$XDG_DATA_HOME/wget-hsts\""

# thefuck utility configuration and aliases
# eval $(thefuck --alias)
# alias f="fuck"

# Use Neovim as default editor
alias notesvim="NVIM_APPNAME=nvim-notesvim nvim"
alias truenvim="NVIM_APPNAME=nvim nvim"

alias nvimconf="cd $XDG_CONFIG_HOME/$NVIM_APPNAME/"

# Sudo with alias
alias sudo="sudo "

# Memes
alias pls="sudo "

# Rsync
alias copy="rsync -rlptUDh --info=PROGRESS2 --mkpath "
alias mov="copy --remove-source-files "

# IP
alias ipa="ip -color a"

# Pipx autocomplete
eval "$(register-python-argcomplete pipx)"

# Do not attempt autocorrection for specific commands
nocorrectlist=("ytfzf" "yt-dlp")
for item in $nocorrectlist; do alias $item="nocorrect $item ";done

# Show p10k prompt
[[ ! -f ${ZDOTDIR:-~}/.p10k.zsh ]] || source ${ZDOTDIR:-~}/.p10k.zsh

# zprof
