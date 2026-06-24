-- https://wiki.hyprland.org/Configuring/Window-Rules/
-- https://wiki.hyprland.org/Configuring/Workspace-Rules/
-- MAINMOD ("SUPER") is a global constant defined in variables.lua

-- No rounding if only one window on workspace
hl.workspace_rule({ workspace = "w[t1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = true }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "w[t1]s[false]" }, rounding = 0 })

-- Music players
hl.workspace_rule({
	workspace = "special:music",
	on_created_empty = "[workspace special:music] " .. terminal("ytm"),
	persistent = false,
})
hl.bind(MAINMOD .. " + m", hl.dsp.workspace.toggle_special("music"))
hl.on("hyprland.shutdown", function()
	hl.exec_cmd("pkill -SIGHUP musikcube")
end)

-- YouTube player workspace (similar to music workspace)
hl.workspace_rule({
	workspace = "special:youtube",
	on_created_empty = "[workspace special:youtube] killall freetube; "
		.. UWSM_APP
		.. "freetube --enable-features=AcceleratedVideoDecodeLinuxGL",
	persistent = false,
})
hl.bind(MAINMOD .. " + y", hl.dsp.workspace.toggle_special("youtube"))

-- Auto launch special workspace apps
hl.workspace_rule({
	workspace = "special:s1",
	on_created_empty = "[workspace special:s1] " .. tmux("", "Hyprland"),
	persistent = false,
})
hl.workspace_rule({
	workspace = "special:s6",
	on_created_empty = "[workspace special:s6] " .. terminal("radeontop -c -T"),
	persistent = false,
})
hl.workspace_rule({
	workspace = "special:s7",
	on_created_empty = "[workspace special:s7] " .. terminal("nvtop -d 15"),
	persistent = false,
})
hl.workspace_rule({
	workspace = "special:s8",
	on_created_empty = "[workspace special:s8] " .. terminal("battop -d 20"),
	persistent = false,
})
hl.workspace_rule({
	workspace = "special:s9",
	on_created_empty = "[workspace special:s9] " .. terminal("btop"),
	persistent = false,
})
hl.workspace_rule({
	workspace = "special:s10",
	on_created_empty = "[workspace special:s10] killall thunderbird; " .. UWSM_APP_A .. "thunderbird",
	persistent = false,
})

-- Discord/Vesktop inside special workspace
hl.window_rule({
	name = "discord",
	workspace = "special:discord",
	match = { initial_class = "vesktop" },
})

-- Thunderbird inside special workspace (safety net: the silent autostart exec in hyprland.lua
-- can't reliably track the window because uwsm launches it into a detached systemd scope, so it
-- would otherwise land on the current workspace instead of the hidden special:s10).
hl.window_rule({
	name = "thunderbird",
	workspace = "special:s10",
	match = { initial_class = "org.mozilla.Thunderbird" },
})

-- Waybar layer
hl.layer_rule({
	name = "waybar",
	blur = true,
	match = { namespace = "waybar" },
})

-- Notifications layer
hl.layer_rule({
	name = "notifications",
	above_lock = 1,
	blur = true,
	animation = "slidefade",
	match = { namespace = "notifications" },
})

-- KDE Connect pointer
hl.window_rule({
	name = "kde-connect-pointer",
	float = true,
	pin = true,
	no_initial_focus = true,
	allows_input = false,
	rounding = 0,
	border_size = 0,
	no_blur = true,
	no_shadow = true,
	no_anim = true,
	move = { 0, 0 },
	size = { "monitor_w", "monitor_h" }, -- full monitor
	match = { initial_class = "org.kde.kdeconnect.daemon", initial_title = "KDE Connect Daemon" },
})

-- Pip variables
local PIP_ROUNDING = 0
local PIP_POS_X = 1061
local PIP_POS_Y = 691
local PIP_SIZE_WIDTH = 472 -- 1920:1080::530:298.125
local PIP_SIZE_HEIGHT = 266

-- Firefox/LibreWolf pip
hl.window_rule({
	name = "firefox-pip",
	float = true,
	pin = true,
	no_initial_focus = true,
	rounding = PIP_ROUNDING,
	move = { PIP_POS_X, PIP_POS_Y },
	size = { PIP_SIZE_WIDTH, PIP_SIZE_HEIGHT },
	match = { title = "Picture-in-Picture" },
})

-- FreeTube pip
hl.window_rule({
	name = "freetube-pip",
	float = true,
	pin = true,
	no_initial_focus = true,
	rounding = PIP_ROUNDING,
	move = { PIP_POS_X, PIP_POS_Y },
	size = { PIP_SIZE_WIDTH, PIP_SIZE_HEIGHT },
	match = { initial_title = "Picture in picture" },
})

-- GTK Pinentry
hl.window_rule({
	name = "gtk-pinentry-focus",
	stay_focused = true,
	match = { class = "gcr-prompter" },
})

-- KeepassXC
hl.window_rule({
	name = "keepassxc-unlock",
	float = true,
	stay_focused = true,
	match = { class = "org.keepassxc.KeePassXC", title = "Unlock Database - KeePassXC" },
})

hl.window_rule({
	name = "keepassxc-access",
	float = true,
	stay_focused = true,
	match = { class = "org.keepassxc.KeePassXC", title = "KeePassXC -  Access Request" },
})

hl.window_rule({
	name = "keepassxc-browser",
	float = true,
	stay_focused = true,
	match = { class = "org.keepassxc.KeePassXC", title = "KeePassXC - Browser Access Request" },
})

hl.window_rule({
	name = "keepassxc-passkey",
	float = true,
	stay_focused = true,
	match = { class = "org.keepassxc.KeePassXC", title = "KeePassXC - Passkey credentials" },
})

-- Mate polkit password prompt
hl.window_rule({
	name = "polkit-focus",
	stay_focused = true,
	match = { class = "polkit-mate-authentication-agent-1", title = "Authenticate" },
})

hl.window_rule({
	name = "usbguard-qt",
	float = true,
	stay_focused = true,
	match = { class = "usbguard-qt", title = "USB Device Inserted" },
})

-- Thunderbird message filters floating
hl.window_rule({
	name = "thunderbird-filters",
	float = true,
	match = { title = "^(Message Filters)$", class = "^(org.mozilla.Thunderbird)$" },
})

-- SafeEyes (ignore other keybinds if safeeyes is active)
hl.define_submap("safeeyes", function()
	hl.bind("catchall", hl.dsp.exec_cmd(":"))
end)
hl.window_rule({
	name = "safeeyes-force",
	workspace = "special:safeeyes",
	stay_focused = true,
	fullscreen = true,
	match = { class = "^(io.github.slgobinath.SafeEyes)$", title = [[^(SafeEyes-\d)$]] },
})

-- Float editing window of nm-connection-editor
hl.window_rule({
	name = "nm-editor-float",
	float = true,
	match = { class = "nm-connection-editor", title = "Editing.*" },
})

-- Disable animations for ueberzug
hl.window_rule({
	name = "ueberzug-noanim",
	no_anim = true,
	match = { class = "ueberzugpp_.*" },
})

-- Screen tearing for games
hl.window_rule({
	name = "game-tearing-xdg-tag",
	match = { content = "game" },
	immediate = true,
})

hl.window_rule({
	name = "game-tearing-gamescope",
	match = { initial_class = "gamescope" },
	immediate = true,
})

-- Permissions
hl.permission({ binary = "/usr/bin/grim", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/bin/wf-recorder", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/bin/wayfreeze", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/bin/still", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/bin/hyprlock", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })

-- hl.permission({ binary = "power-button", type = "keyboard", mode = "allow" })
-- hl.permission({ binary = "video-bus", type = "keyboard", mode = "allow" })
-- hl.permission({ binary = "power-button-1", type = "keyboard", mode = "allow" })
-- hl.permission({ binary = "sleep-button", type = "keyboard", mode = "allow" })
-- hl.permission({ binary = "intel-hid-events", type = "keyboard", mode = "allow" })
-- hl.permission({ binary = "intel-hid-5-button-array", type = "keyboard", mode = "allow" })
-- hl.permission({ binary = "dell-wmi-hotkeys", type = "keyboard", mode = "allow" })
-- hl.permission({ binary = "at-translated-set-2-keyboard", type = "keyboard", mode = "allow" })
-- hl.permission({ binary = "at-translated-set-2-keyboard-1", type = "keyboard", mode = "allow" })
--
-- hl.permission({ binary = ".*", type = "keyboard", mode = "deny" })

-- Event listeners ("rules" that react to Hyprland events). Shared state used by these lives in
-- variables.lua (set_touchpad/touchpad_enabled, windowlock_addr/windowlock_disarm).

-- Whenever the *currently focused* window is in real fullscreen (mode 2, not maximize),
-- disable the touchpad and dim the keyboard backlight; restore both as soon as focus moves to
-- a window that is not fullscreen-2 (or away from any window). Native, generic replacement for
-- the old scripts/mpv-touchpad.sh socat daemon (now applies to any window, not just mpv). The
-- touchpad toggle keybind that shares this state lives in keybinds.lua.
-- NOTE: verify the window `fullscreen` field reports 2 for true fullscreen on your version.
local fullscreen_active = false
local touchpad_before_fullscreen = true
local function sync_fullscreen_state()
	local active = hl.get_active_window()
	local is_fullscreen = active ~= nil and active.fullscreen == 2
	if is_fullscreen == fullscreen_active then
		return -- the focused window's fullscreen-2 status hasn't changed
	end
	fullscreen_active = is_fullscreen
	if is_fullscreen then
		touchpad_before_fullscreen = touchpad_enabled
		set_touchpad(false)
		hl.exec_cmd("brightnessctl --device='" .. KBD_BACKLIGHT .. "' -s set 0") -- -s saves the current level
	else
		set_touchpad(touchpad_before_fullscreen) -- restore the pre-fullscreen touchpad state
		hl.exec_cmd("brightnessctl --device='" .. KBD_BACKLIGHT .. "' -r") -- -r restores the saved level
	end
end
hl.on("window.fullscreen", sync_fullscreen_state) -- the focused window toggled fullscreen
hl.on("window.active", sync_fullscreen_state) -- focus moved to a different window

-- Window lock (was scripts/windowlock.sh socat daemon): lock the session the moment focus
-- leaves the window that the SHIFT+ALT+l keybind armed (see keybinds.lua), then disarm.
hl.on("window.active", function(w)
	if windowlock_addr == nil then
		return
	end
	if w == nil or w.address ~= windowlock_addr then
		windowlock_disarm()
		hl.exec_cmd("loginctl lock-session")
	end
end)

-- SafeEyes inhibit (was scripts/safeeyes-inhibit.sh socat daemon): when a SafeEyes break
-- window opens, save+kill the keyboard backlight and enter the `safeeyes` submap (an empty
-- submap, so all non-universal keys are inert during the break); restore both when its special
-- workspace is destroyed. Native window.open / workspace.removed handlers replace the socat
-- event loop and its string parsing of the openwindow/destroyworkspace lines.
hl.on("window.open", function(w)
	if w == nil or w.class ~= "safeeyes" then
		return
	end
	if w.title == nil or w.title:match("^SafeEyes%-%d$") == nil then
		return
	end
	hl.exec_cmd("brightnessctl --device='" .. KBD_BACKLIGHT .. "' -s set 0")
	hl.dispatch(hl.dsp.submap("safeeyes"))
end)
hl.on("workspace.removed", function(ws)
	if ws ~= nil and ws.name == "special:safeeyes" then
		hl.dispatch(hl.dsp.submap("reset"))
		hl.exec_cmd("brightnessctl --device='" .. KBD_BACKLIGHT .. "' -r")
	end
end)
