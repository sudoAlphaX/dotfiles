# Firejail profile for /usr/lib/packettracer/packettracer.AppImage
# Persistent local customizations
#include /usr/lib/packettracer/packettracer.AppImage.local
# Persistent global definitions
include globals.local

### Basic Blacklisting ###
include disable-common.inc	# dangerous directories like ~/.ssh and ~/.gnupg
include disable-devel.inc	# development tools such as gcc and gdb
include disable-exec.inc	# non-executable directories such as /var, /tmp, and /home
include disable-interpreters.inc	# perl, python, lua etc.
include disable-programs.inc	# user configuration for programs such as firefox, vlc etc.
include disable-shell.inc	# sh, bash, zsh etc.
include disable-xdg.inc	# standard user directories: Documents, Pictures, Videos, Music

### Home Directory Whitelisting ###

mkdir ${HOME}/.local/share/PacketTracer
mkdir ${HOME}/.local/.packettracer
mkdir ${HOME}/.local/.packettracer
mkdir ${HOME}/.cache/Cisco Packet Tracer
mkdir ${HOME}/pt
mkdir ${HOME}/.packettracer

whitelist ${HOME}/.local/share/PacketTracer
whitelist ${HOME}/.local/.packettracer
whitelist ${HOME}/.local/.packettracer
whitelist ${HOME}/.cache/Cisco Packet Tracer
whitelist ${HOME}/pt
whitelist ${HOME}/.packettracer
whitelist ${HOME}/Downloads

### Filesystem Whitelisting ###
include whitelist-common.inc
include whitelist-run-common.inc
include whitelist-runuser-common.inc
include whitelist-var-common.inc

# apparmor	# if you have AppArmor running, try this one!
caps.drop all
ipc-namespace
netfilter
#no3d	# disable 3D acceleration
nodvd	# disable DVD and CD devices
nogroups	# disable supplementary user groups
#noinput	# disable input devices
nonewprivs
noroot
notv
nou2f
novideo
protocol unix,inet,inet6,netlink
net none
netfilter
seccomp !chroot
machine-id

disable-mnt
private-lib
private-tmp
dbus-user none
dbus-system none

memory-deny-write-execute
