
## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

# Always copy contents of directories (r)ecursively and explain (v) what was done
alias cp='cp -rv'
# Explain (v) what was done when moving a file
alias mv='mv -v'

# Create any non-existent (p)arent directories and explain (v) what was done
alias mkdir='mkdir -pv'

# Quick shortcut for ls
alias l="ls"
# List contents with colors for file types, (A)lmost all hidden files (without . and ..), in (C)olumns, with class indicators (F)
alias ls='ls --color=auto -CF'
# List contents with colors for file types, (a)ll hidden entries (including . and ..), use (l)ong listing format, with class indicators >
alias ll='ls --color=auto -alF'
## Show hidden files ##
alias l.='ls -dACF .* --color=auto'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Always try to (c)ontinue getting a partially-downloaded file
alias wget='wget -c'

# Find current directory for given name
alias fhere="find . -name "

# Search history for command
alias histg="history | grep"

# thefuck utility configuration and aliases
eval $(TF_SHELL=$(basename $SHELL) thefuck --alias)
alias f="fuck"

# speedtest-go alias
alias fast="speedtest-go -m"

# Use Neovim as default editor 
alias vi="nvim"

