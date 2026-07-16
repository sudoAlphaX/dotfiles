#!/usr/bin/sh
hyprctl eval 'hl.window_rule({ name = "lowpower-opaque", match = { class = "Alacritty" }, opaque = true })'
