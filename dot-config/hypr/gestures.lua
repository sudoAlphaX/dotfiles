-- https://wiki.hyprland.org/Configuring/Gestures/
-- gesture: hl.gesture({ fingers, direction, action[, mods, scale, ...] })
hl.gesture({ fingers = 3, direction = "vertical", action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
-- hl.gesture({ fingers = 4, direction = "horizontal", action = "resize" })
