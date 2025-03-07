##### omz configuration #####


# Disable automatic updates
zstyle ':omz:update' mode disabled

# Show loading prompt
COMPLETION_WAITING_DOTS=true

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

# LS_COLORS
export LS_COLORS="$(vivid generate catppuccin-mocha)"

##### omz plugins configuration #####
plugins=()

plugins+=(aliases)

plugins+=(alias-finder)
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer no
zstyle ':omz:plugins:alias-finder' exact no
zstyle ':omz:plugins:alias-finder' cheaper yes

plugins+=(bgnotify)
bgnotify_bell=true
bgnotify_threshold=2
bgnotify_extraargs="-a zsh"
# function bgnotify_formatted {
#   ## $1=exit_status, $2=command, $3=elapsed_time
#
#   # Humanly readable elapsed time
#   local elapsed="$(( $3 % 60 ))s"
#   (( $3 < 60 ))   || elapsed="$((( $3 % 3600) / 60 ))m $elapsed"
#   (( $3 < 3600 )) || elapsed="$((  $3 / 3600 ))h $elapsed"
#
#   [ $1 -eq 0 ] && title="Holy Smokes Batman" || title="Holy Graf Zeppelin"
#   [ $1 -eq 0 ] && icon="$HOME/icons/success.png" || icon="$HOME/icons/fail.png"
#   bgnotify "$title - took ${elapsed}" "$2" "$icon"
# }
#

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

# ufw completion
plugins+=(ufw)

# Archive utilities
plugins+=(extract universalarchive)

# Auto activate python virtualenv
plugins+=(virtualenvwrapper)

# Z
plugins+=(z)


#### END omz plugins configuration #####

# Sourcing
source $ZSH/oh-my-zsh.sh
source $ZDOTDIR/.zshalias
