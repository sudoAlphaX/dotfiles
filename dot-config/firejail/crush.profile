# Firejail profile for claude
# agents config
include agents.profile
# Persistent local customizations
include claude.local
# Persistent global definitions
include globals.local

whitelist ${HOME}/.config/crush
whitelist ${HOME}/.local/share/crush
