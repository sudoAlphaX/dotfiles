noblacklist ${HOME}/.config/vesktop

mkdir ${HOME}/.config/vesktop
whitelist ${HOME}/.config/vesktop

private-bin vesktop
private-opt vesktop

ignore join-or-start discord
join-or-start vesktop

# Redirect
include discord-common.profile
