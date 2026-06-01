-- https://wiki.hyprland.org/Plugins/Using-Plugins/
-- MAINMOD ("SUPER") is a global constant defined in variables.lua

-- Alternative startup (kept for reference):
-- hl.on("hyprland.start", function() hl.exec_cmd("sleep 10 && ((hyprpm update; hyprpm reload) && ((hyprctl keyword bind ALT,TAB,hyprexpo:expo,toggle)))") end)

-- Load plugins at startup; if reload fails, open a tmux session to update then reload
hl.on("hyprland.start", function()
	hl.dispatch(
		hl.dsp.exec_cmd(
			"hyprpm reload || " .. tmux("hyprpm update", "hyprland-plugins") .. " && hyprpm reload",
			{ workspace = "special:s2" }
		)
	)
end)

-- hl.exec_cmd("hyprctl keyword bind ALT,TAB,hyprexpo:expo,toggle")
-- hl.exec_cmd("hyprctl keyword bind " .. MAINMOD .. ",grave,overview:toggle")

-- Permissions
-- hl.permission({ binary = "/var/cache/hyprpm/$USER/hyprland-plugins/hyprexpo.so", type = "plugin", mode = "allow" })
-- hl.permission({ binary = "/var/cache/hyprpm/$USER/hyprland-plugins/xtra-dispatchers.so", type = "plugin", mode = "allow" })

-- Plugin binds (plugin dispatchers use hl.plugin.<name>.<dispatcher>(...); verify args against the plugin when re-enabling)
-- hl.bind(MAINMOD .. " + grave", hl.plugin.hyprexpo.expo("toggle")) -- can be: toggle, off/disable or on/enable
-- hl.bind(MAINMOD .. " + grave", hl.plugin.overview.toggle())
--
-- xtra-dispatchers
-- Move all unactive windows to a workspace with MAINMOD + ALT + [0-9]
-- hl.bind(MAINMOD .. " + ALT + 1", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused 1; hyprctl dispatch workspace 1"))
-- hl.bind(MAINMOD .. " + ALT + 2", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused 2; hyprctl dispatch workspace 2"))
-- hl.bind(MAINMOD .. " + ALT + 3", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused 3; hyprctl dispatch workspace 3"))
-- hl.bind(MAINMOD .. " + ALT + 4", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused 4; hyprctl dispatch workspace 4"))
-- hl.bind(MAINMOD .. " + ALT + 5", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused 5; hyprctl dispatch workspace 5"))
-- hl.bind(MAINMOD .. " + ALT + 6", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused 6; hyprctl dispatch workspace 6"))
-- hl.bind(MAINMOD .. " + ALT + 7", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused 7; hyprctl dispatch workspace 7"))
-- hl.bind(MAINMOD .. " + ALT + 8", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused 8; hyprctl dispatch workspace 8"))
-- hl.bind(MAINMOD .. " + ALT + 9", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused 9; hyprctl dispatch workspace 9"))
-- hl.bind(MAINMOD .. " + ALT + 0", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused 10; hyprctl dispatch workspace 10"))
--
-- Move all unactive windows to a special workspace with MAINMOD + CTRL + ALT + [0-9]
-- hl.bind(MAINMOD .. " + CTRL + ALT + 1", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused special:s1; hyprctl dispatch togglespecialworkspace s1"))
-- hl.bind(MAINMOD .. " + CTRL + ALT + 2", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused special:s2; hyprctl dispatch togglespecialworkspace s2"))
-- hl.bind(MAINMOD .. " + CTRL + ALT + 3", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused special:s3; hyprctl dispatch togglespecialworkspace s3"))
-- hl.bind(MAINMOD .. " + CTRL + ALT + 4", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused special:s4; hyprctl dispatch togglespecialworkspace s4"))
-- hl.bind(MAINMOD .. " + CTRL + ALT + 5", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused special:s5; hyprctl dispatch togglespecialworkspace s5"))
-- hl.bind(MAINMOD .. " + CTRL + ALT + 6", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused special:s6; hyprctl dispatch togglespecialworkspace s6"))
-- hl.bind(MAINMOD .. " + CTRL + ALT + 7", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused special:s7; hyprctl dispatch togglespecialworkspace s7"))
-- hl.bind(MAINMOD .. " + CTRL + ALT + 8", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused special:s8; hyprctl dispatch togglespecialworkspace s8"))
-- hl.bind(MAINMOD .. " + CTRL + ALT + 9", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused special:s9; hyprctl dispatch togglespecialworkspace s9"))
-- hl.bind(MAINMOD .. " + CTRL + ALT + 0", hl.dsp.exec_cmd("hyprctl dispatch plugin:xtd:throwunfocused special:s10; hyprctl dispatch togglespecialworkspace s10"))

-- Plugin configuration (applied even before the plugin loads; Hyprland stores plugin
-- values and pushes them once the plugin registers, mirroring the old `plugin {}` block)
-- hl.config({
-- 	plugin = {
-- 		hyprexpo = {
-- 			columns = 3,
-- 			gap_size = 5,
-- 			bg_col = "rgb(111111)",
-- 			workspace_method = "first 1", -- [center/first] [workspace] e.g. first 1 or center m+1
--
-- 			enable_gesture = true, -- laptop touchpad, 4 fingers
-- 		},
--
-- 		overview = {
-- 			disableGestures = true,
-- 			reverseSwipe = true,
-- 			showSpecialWorkspace = false,
-- 		},
-- 	},
-- })
