-- https://wiki.hyprland.org/Configuring/Monitors/

local TRANSFORM = 0 -- eDP-1 base rotation (was $transform); runtime rotation handled by keybinds.lua

hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1.25, transform = TRANSFORM })
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = "auto", mirror = "eDP-1" })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
