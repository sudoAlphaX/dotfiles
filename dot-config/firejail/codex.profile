# Firejail profile for claude
# agents config
include agents.profile
# Persistent local customizations
include codex.local
# Persistent global definitions
include globals.local

whitelist ${HOME}/.codex
