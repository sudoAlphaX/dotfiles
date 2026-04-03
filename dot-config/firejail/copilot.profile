# Firejail profile for copilot
# agents config
include agents.profile
# Persistent local customizations
include copilot.local
# Persistent global definitions
include globals.local

whitelist ${HOME}/.config/github-copilot
whitelist ${HOME}/.config/.copilot
whitelist ${HOME}/.local/state/.copilot

ignore dbus-user none
