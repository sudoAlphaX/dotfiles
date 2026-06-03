-- https://wiki.hyprland.org/Configuring/Binds/
-- MAINMOD ("SUPER") is a global constant defined in variables.lua

hl.bind(MAINMOD .. " + w", hl.dsp.exec_cmd(TERMINAL))
hl.bind(MAINMOD .. " + SHIFT + w", hl.dsp.exec_cmd(terminal("zsh"), { float = true, center = true, no_blur = true }))
hl.bind(MAINMOD .. " + q", hl.dsp.window.close())
hl.bind(MAINMOD .. " + f", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(MAINMOD .. " + SHIFT + f", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(MAINMOD .. " + p", hl.dsp.window.float())
hl.bind(MAINMOD .. " + SHIFT + p", hl.dsp.window.pin())
hl.bind(MAINMOD .. " + b", hl.dsp.exec_cmd(UWSM_APP .. "librewolf"))
hl.bind(
	MAINMOD .. " + r",
	hl.dsp.exec_cmd(
		"rofi -show drun -theme "
			.. HOME
			.. '/.config/rofi/launchers/type-1/style-10.rasi -run-command "uwsm app -- {cmd}"'
	)
)
-- hl.bind(MAINMOD .. " + ALT + r", hl.dsp.exec_cmd(MENU_ALL)) -- $menu_all was never defined in variables.conf
hl.bind(MAINMOD .. " + t", hl.dsp.layout("togglesplit"))
hl.bind(MAINMOD .. " + TAB", hl.dsp.focus({ workspace = "previous" }))
hl.bind("ALT + TAB", hl.dsp.focus({ last = true }))
hl.bind(MAINMOD .. " + SHIFT + TAB", hl.dsp.window.move({ workspace = "previous", follow = true }))
hl.bind(MAINMOD .. " + e", hl.dsp.exec_cmd(terminal(FILEMANAGER_APP)))
hl.bind(MAINMOD .. " + SHIFT + e", hl.dsp.exec_cmd(terminal(FILEMANAGER_APP), { float = true, center = true, no_blur = true }))
hl.bind(MAINMOD .. " + CTRL + x", hl.dsp.window.signal({ signal = 9 })) -- SIGKILL the focused window's process
hl.bind(MAINMOD .. " + C", hl.dsp.exec_cmd(terminal(CALCULATOR_APP)))
hl.bind(MAINMOD .. " + SHIFT + C", hl.dsp.exec_cmd(terminal(CALCULATOR_APP), { float = true, center = true, no_blur = true }))

-- Navigating and moving windows to workspaces
hl.bind(MAINMOD .. " + CTRL + code:35", hl.dsp.focus({ workspace = "r+1" })) -- use ] to go to the next workspace
hl.bind(MAINMOD .. " + CTRL + code:34", hl.dsp.focus({ workspace = "r-1" })) -- use [ to go to the previous workspace
hl.bind(MAINMOD .. " + code:35", hl.dsp.focus({ workspace = "e+1" })) -- use ] to go to the next open workspace
hl.bind(MAINMOD .. " + code:34", hl.dsp.focus({ workspace = "e-1" })) -- use [ to go to the previous open workspace
hl.bind(MAINMOD .. " + SHIFT + code:35", hl.dsp.window.move({ workspace = "r+1", follow = true })) -- move window to next workspace
hl.bind(MAINMOD .. " + SHIFT + code:34", hl.dsp.window.move({ workspace = "r-1", follow = true })) -- move window to previous workspace
hl.bind(MAINMOD .. " + CTRL + SHIFT + code:35", hl.dsp.window.move({ workspace = "e+1", follow = true })) -- move window to next open workspace
hl.bind(MAINMOD .. " + CTRL + SHIFT + code:34", hl.dsp.window.move({ workspace = "e-1", follow = true })) -- move window to previous open workspace
hl.bind(MAINMOD .. " + CTRL + i", hl.dsp.focus({ workspace = "r+1" })) -- use i to go to the next workspace
hl.bind(MAINMOD .. " + CTRL + u", hl.dsp.focus({ workspace = "r-1" })) -- use u to go to the previous workspace
hl.bind(MAINMOD .. " + i", hl.dsp.focus({ workspace = "e+1" })) -- use i to go to the next open workspace
hl.bind(MAINMOD .. " + u", hl.dsp.focus({ workspace = "e-1" })) -- use u to go to the previous open workspace
hl.bind(MAINMOD .. " + SHIFT + i", hl.dsp.window.move({ workspace = "r+1", follow = true })) -- move window to next workspace
hl.bind(MAINMOD .. " + SHIFT + u", hl.dsp.window.move({ workspace = "r-1", follow = true })) -- move window to previous workspace
hl.bind(MAINMOD .. " + CTRL + SHIFT + i", hl.dsp.window.move({ workspace = "e+1", follow = true })) -- move window to next open workspace
hl.bind(MAINMOD .. " + CTRL + SHIFT + u", hl.dsp.window.move({ workspace = "e-1", follow = true })) -- move window to previous open workspace
hl.bind(MAINMOD .. " + o", hl.dsp.focus({ workspace = "empty" })) -- go to an empty workspace
hl.bind(MAINMOD .. " + SHIFT + o", hl.dsp.window.move({ workspace = "empty", follow = true })) -- move window to an empty workspace

-- Move focus with MAINMOD + vim keybinds
-- NOTE: the Lua hl.dsp API expects full direction words (left/right/up/down), not the
-- single letters l/r/u/d the wiki still shows; single letters error as "invalid direction".
hl.bind(MAINMOD .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(MAINMOD .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(MAINMOD .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(MAINMOD .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move window (was scripts/window-movement.sh): floating windows move by pixels, tiled by direction
local MOVE_STEP = 20
local MOVE_DELTAS =
	{ left = { -MOVE_STEP, 0 }, right = { MOVE_STEP, 0 }, up = { 0, -MOVE_STEP }, down = { 0, MOVE_STEP } }
local function move_window(direction)
	local w = hl.get_active_window()
	if w ~= nil and w.floating then
		local delta = MOVE_DELTAS[direction]
		hl.dispatch(hl.dsp.window.move({ x = delta[1], y = delta[2], relative = true }))
	else
		hl.dispatch(hl.dsp.window.move({ direction = direction }))
	end
end
hl.bind(MAINMOD .. " + SHIFT + h", function()
	move_window("left")
end, { repeating = true })
hl.bind(MAINMOD .. " + SHIFT + j", function()
	move_window("down")
end, { repeating = true })
hl.bind(MAINMOD .. " + SHIFT + k", function()
	move_window("up")
end, { repeating = true })
hl.bind(MAINMOD .. " + SHIFT + l", function()
	move_window("right")
end, { repeating = true })

-- Swap window or move floating to edges (was scripts/window-swap.sh)
local function swap_window(direction)
	local w = hl.get_active_window()
	if w ~= nil and w.floating then
		hl.dispatch(hl.dsp.window.move({ direction = direction }))
	else
		hl.dispatch(hl.dsp.window.swap({ direction = direction }))
	end
end
hl.bind(MAINMOD .. " + CTRL + SHIFT + h", function()
	swap_window("left")
end)
hl.bind(MAINMOD .. " + CTRL + SHIFT + j", function()
	swap_window("down")
end)
hl.bind(MAINMOD .. " + CTRL + SHIFT + k", function()
	swap_window("up")
end)
hl.bind(MAINMOD .. " + CTRL + SHIFT + l", function()
	swap_window("right")
end)

-- Resizing current window
hl.bind(MAINMOD .. " + CTRL + l", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(MAINMOD .. " + CTRL + h", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(MAINMOD .. " + CTRL + k", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(MAINMOD .. " + CTRL + j", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

hl.bind(MAINMOD .. " + CTRL + right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
hl.bind(MAINMOD .. " + CTRL + left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
hl.bind(MAINMOD .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
hl.bind(MAINMOD .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

-- Switch workspaces with MAINMOD + [0-9]
hl.bind(MAINMOD .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(MAINMOD .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(MAINMOD .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(MAINMOD .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(MAINMOD .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(MAINMOD .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(MAINMOD .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(MAINMOD .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(MAINMOD .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(MAINMOD .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with MAINMOD + SHIFT + [0-9]
hl.bind(MAINMOD .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1, follow = true }))
hl.bind(MAINMOD .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2, follow = true }))
hl.bind(MAINMOD .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3, follow = true }))
hl.bind(MAINMOD .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4, follow = true }))
hl.bind(MAINMOD .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5, follow = true }))
hl.bind(MAINMOD .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6, follow = true }))
hl.bind(MAINMOD .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7, follow = true }))
hl.bind(MAINMOD .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8, follow = true }))
hl.bind(MAINMOD .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9, follow = true }))
hl.bind(MAINMOD .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10, follow = true }))

-- Move/resize windows with MAINMOD + LMB/RMB and dragging
hl.bind(MAINMOD .. " + mouse:272", hl.dsp.window.resize(), { mouse = true })
hl.bind(MAINMOD .. " + SHIFT + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- Scroll through existing workspaces with MAINMOD + scroll
hl.bind(MAINMOD .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(MAINMOD .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Scroll through all workspaces with CTRL + MAINMOD + scroll
hl.bind(MAINMOD .. " + CTRL + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(MAINMOD .. " + CTRL + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Special workspaces
hl.bind(MAINMOD .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(MAINMOD .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic", follow = true }))
hl.bind(MAINMOD .. " + D", hl.dsp.workspace.toggle_special("discord"))
hl.bind(MAINMOD .. " + SHIFT + D", hl.dsp.window.move({ workspace = "special:discord", follow = true }))

-- If the last window in the active (non-special) workspace is not fullscreen or is the active window, toggle the special workspace twice to ensure it is activated, else toggle it once because launching a special workspace when a window is fullscreen dismisses the active special workspace instead of replacing it.
-- hl.bind(MAINMOD .. " + A", hl.dsp.exec_cmd([[(lastwindow=$(hyprctl activeworkspace -j | jq '.lastwindow'); if [ "$(hyprctl clients -j | jq ".[] | select((.address==$lastwindow)).fullscreen")" != 2 ] || [ "$(hyprctl activewindow -j | jq '.address')" = "$lastwindow" ]; then hyprctl dispatch togglespecialworkspace; fi; hyprctl dispatch togglespecialworkspace) > /dev/null]]))
hl.bind(MAINMOD .. " + A", function()
	-- toggle the unnamed special workspace twice (was bare `togglespecialworkspace` x2)
	hl.dispatch(hl.dsp.workspace.toggle_special(""))
	hl.dispatch(hl.dsp.workspace.toggle_special(""))
end)
hl.bind(MAINMOD .. " + SHIFT + A", hl.dsp.window.move({ workspace = "e+0", follow = true })) -- Move window from special workspace to active workspace

hl.bind(MAINMOD .. " + CTRL + 1", hl.dsp.workspace.toggle_special("s1"))
hl.bind(MAINMOD .. " + CTRL + 2", hl.dsp.workspace.toggle_special("s2"))
hl.bind(MAINMOD .. " + CTRL + 3", hl.dsp.workspace.toggle_special("s3"))
hl.bind(MAINMOD .. " + CTRL + 4", hl.dsp.workspace.toggle_special("s4"))
hl.bind(MAINMOD .. " + CTRL + 5", hl.dsp.workspace.toggle_special("s5"))
hl.bind(MAINMOD .. " + CTRL + 6", hl.dsp.workspace.toggle_special("s6"))
hl.bind(MAINMOD .. " + CTRL + 7", hl.dsp.workspace.toggle_special("s7"))
hl.bind(MAINMOD .. " + CTRL + 8", hl.dsp.workspace.toggle_special("s8"))
hl.bind(MAINMOD .. " + CTRL + 9", hl.dsp.workspace.toggle_special("s9"))
hl.bind(MAINMOD .. " + CTRL + 0", hl.dsp.workspace.toggle_special("s10"))
hl.bind(MAINMOD .. " + CTRL + SHIFT + 1", hl.dsp.window.move({ workspace = "special:s1", follow = true }))
hl.bind(MAINMOD .. " + CTRL + SHIFT + 2", hl.dsp.window.move({ workspace = "special:s2", follow = true }))
hl.bind(MAINMOD .. " + CTRL + SHIFT + 3", hl.dsp.window.move({ workspace = "special:s3", follow = true }))
hl.bind(MAINMOD .. " + CTRL + SHIFT + 4", hl.dsp.window.move({ workspace = "special:s4", follow = true }))
hl.bind(MAINMOD .. " + CTRL + SHIFT + 5", hl.dsp.window.move({ workspace = "special:s5", follow = true }))
hl.bind(MAINMOD .. " + CTRL + SHIFT + 6", hl.dsp.window.move({ workspace = "special:s6", follow = true }))
hl.bind(MAINMOD .. " + CTRL + SHIFT + 7", hl.dsp.window.move({ workspace = "special:s7", follow = true }))
hl.bind(MAINMOD .. " + CTRL + SHIFT + 8", hl.dsp.window.move({ workspace = "special:s8", follow = true }))
hl.bind(MAINMOD .. " + CTRL + SHIFT + 9", hl.dsp.window.move({ workspace = "special:s9", follow = true }))
hl.bind(MAINMOD .. " + CTRL + SHIFT + 0", hl.dsp.window.move({ workspace = "special:s10", follow = true }))

-- Volume controls
-- Helper: notify-send showing the current sink volume with the given icon (keybind-specific, kept local)
local function volume_notify(icon)
	return [[notify-send --icon ]]
		.. ICONS_PATH
		.. [[/audio/]]
		.. icon
		.. [[ --category=device --urgency=low --hint=int:value:$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d?\d?\d%' | head --lines=1 | sed 's/%//g') volume_event]]
end
-- Helper: notify-send showing the current player volume (playerctl)
local function player_volume_notify()
	return [[notify-send --category=device --urgency=low --icon ]]
		.. ICONS_PATH
		.. [[/audio/audio-volume-medium-symbolic.svg --expire-time 3000 --hint=int:value:"$(printf %0.f "$(echo "$(playerctl volume)" '*' 100 | bc )")" volume_event]]
end
local VOL_FLAGS = { locked = true, submap_universal = true }
local PLAYER_VOL_FLAGS = { repeating = true, locked = true, submap_universal = true }
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_SINK@ 0.05+; " .. volume_notify("audio-volume-high-symbolic.svg")),
	VOL_FLAGS
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_SINK@ 0.05-; " .. volume_notify("audio-volume-medium-symbolic.svg")),
	VOL_FLAGS
)
hl.bind(
	"SHIFT + XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_SINK@ 0.01+; " .. volume_notify("audio-volume-high-symbolic.svg")),
	VOL_FLAGS
)
hl.bind(
	"SHIFT + XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_SINK@ 0.01-; " .. volume_notify("audio-volume-medium-symbolic.svg")),
	VOL_FLAGS
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd(
		[[wpctl set-mute @DEFAULT_SINK@ toggle; ]] .. CONF_DIR .. [[/scripts/notify-mute-status.sh ]] .. ICONS_PATH
	),
	VOL_FLAGS
)
hl.bind(
	"CTRL + XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("playerctl volume 0.05+; sleep 0.2; " .. player_volume_notify()),
	PLAYER_VOL_FLAGS
)
hl.bind(
	"CTRL + XF86AudioLowerVolume",
	hl.dsp.exec_cmd("playerctl volume 0.05-; sleep 0.2; " .. player_volume_notify()),
	PLAYER_VOL_FLAGS
)

-- mic mute toggle
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"),
	{ locked = true, submap_universal = true }
)

-- media controls
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play"), { locked = true, submap_universal = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"), { locked = true, submap_universal = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, submap_universal = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true, submap_universal = true })
hl.bind(MAINMOD .. " + n", hl.dsp.exec_cmd("playerctl next"), { locked = true, submap_universal = true })
hl.bind(MAINMOD .. " + SHIFT + n", hl.dsp.exec_cmd("playerctl previous"), { locked = true, submap_universal = true })

-- clipboard manager binds (keyboard history)
hl.bind(
	MAINMOD .. " + v",
	hl.dsp.exec_cmd(
		"cliphist list | rofi -dmenu -theme "
			.. HOME
			.. "/.config/rofi/launchers/type-4/style-2.rasi | cliphist decode | wl-copy"
	)
)

-- power controls
hl.bind(MAINMOD .. " + SHIFT + q", hl.dsp.exec_cmd(POWERMENU), { locked = true })
hl.bind("CTRL + ALT + code:119", hl.dsp.exec_cmd("uwsm stop"), { locked = true, submap_universal = true })
hl.bind("ALT + f4", hl.dsp.exec_cmd(POWERMENU), { locked = true })
hl.bind(
	"CTRL + ALT + l",
	hl.dsp.exec_cmd(
		[[systemd-inhibit --what=idle --why="Hyprlock locked screen while displaying background" hyprlock --config ]]
			.. CONF_DIR
			.. [[/hyprlock-ts.conf]]
	),
	{ submap_universal = true }
)
-- Window lock (was scripts/windowlock.sh): SHIFT+ALT+l arms the lock on the active window and
-- holds a systemd idle inhibitor so hypridle can't lock/suspend before you tab away. The
-- window.active listener that actually locks when focus leaves lives in rules.lua; the shared
-- state (windowlock_addr, windowlock_disarm, WINDOWLOCK_INHIBIT) is defined in variables.lua.
hl.bind("SHIFT + ALT + l", function()
	local w = hl.get_active_window()
	if w == nil then
		return
	end
	windowlock_disarm() -- clear any stale inhibitor before re-arming
	windowlock_addr = w.address
	hl.exec_cmd("notify-send -a Hyprland 'Locking screen on window: " .. (w.class or "") .. "'")
	if w.fullscreen ~= 2 then
		hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen" }))
	end
	hl.exec_cmd("systemd-inhibit --what=idle --why=" .. WINDOWLOCK_INHIBIT .. " sleep infinity &")
end)
hl.bind("ALT + l", hl.dsp.exec_cmd("loginctl lock-session"), { submap_universal = true })

-- Brightness controls
-- Helper: set backlight via brightnessctl (step e.g. "-m s +5%") and notify with the given icon (keybind-specific, kept local)
local function brightness_cmd(step, icon)
	return [[val=$(brightnessctl --device='amdgpu_bl1' ]]
		.. step
		.. [[); notify-send --category=device --urgency=low --icon=]]
		.. ICONS_PATH
		.. [[/brightness/]]
		.. icon
		.. [[ --hint=int:value:$(echo $val | cut --delimiter="," --fields=4 | sed 's/%//') brightness_event]]
end
local BRIGHTNESS_FLAGS = { repeating = true, locked = true, submap_universal = true }
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd(brightness_cmd("-m s +5%", "display-brightness-high-symbolic.svg")),
	BRIGHTNESS_FLAGS
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(brightness_cmd("--min-value=75 -m s 5%-", "display-brightness-medium-symbolic.svg")),
	BRIGHTNESS_FLAGS
)
hl.bind(
	"SHIFT + XF86MonBrightnessUp",
	hl.dsp.exec_cmd(brightness_cmd("-m s +1%", "display-brightness-high-symbolic.svg")),
	BRIGHTNESS_FLAGS
)
hl.bind(
	"SHIFT + XF86MonBrightnessDown",
	hl.dsp.exec_cmd(brightness_cmd("--min-value=75 -m s 1%-", "display-brightness-medium-symbolic.svg")),
	BRIGHTNESS_FLAGS
)

-- Screenshots
hl.bind(
	MAINMOD .. " + CTRL + S",
	hl.dsp.exec_cmd(
		[[mkdir -p "$HOME/tmp/clipboard/screenshots" && filepath="$(mktemp --dry-run --suffix ".png" -p $HOME/tmp/clipboard/screenshots/)" && still -c "grim -g \"\$(slurp -d)\" \"$filepath\""; test -f "$filepath" && notify-send --urgency=low --icon="$filepath" "Screenshot region copied to clipboard" && wl-copy < "$filepath"]]
	)
)
hl.bind(
	"ALT + CTRL + S",
	hl.dsp.exec_cmd(
		[[text="$(still -c "grim -g \"\$(slurp -d)\" -" | tesseract - -)" && wl-copy "$text" && notify-send -t 5000 --urgency=low "Copied \"$text\" to clipboard"]]
	)
)
-- hl.bind("XF86Favorites", hl.dsp.exec_cmd([[grim - | wl-copy && notify-send --urgency=low "Screenshot copied to clipboard"]]))
-- hl.bind("SHIFT + XF86Favorites", hl.dsp.exec_cmd([[grim -g "$(slurp -d)" - | wl-copy && notify-send --urgency=low "Screenshot copied to clipboard"]]))
hl.bind(
	"XF86Favorites",
	hl.dsp.exec_cmd(
		[[mkdir -p "$HOME/tmp/clipboard/screenshots" && filepath="$(mktemp --dry-run --suffix ".png" -p $HOME/tmp/clipboard/screenshots/)" && grim "$filepath" && notify-send --urgency=low --icon="$filepath" "Screenshot copied to clipboard" && wl-copy < "$filepath";]]
	)
)
hl.bind(
	"SHIFT + XF86Favorites",
	hl.dsp.exec_cmd(
		[[mkdir -p "$HOME/tmp/clipboard/screenshots" && filepath="$(mktemp --dry-run --suffix ".png" -p $HOME/tmp/clipboard/screenshots/)" && still -c "grim -g \"\$(slurp -d)\" \"$filepath\""; test -f "$filepath" && notify-send --urgency=low --icon="$filepath" "Screenshot region copied to clipboard" && wl-copy < "$filepath"]]
	)
)
hl.bind(
	"CTRL + XF86Favorites",
	hl.dsp.exec_cmd(
		[[window="$(hyprctl activewindow -j)" && filename="$(date +%Y%m%d_%H%M%S)_$(echo $window | jq -r .class).png" && filepath="$HOME/Pictures/Screenshots/$filename" && grim "$filepath" && notify-send --urgency=low --icon="$filepath" "Screenshot saved as: $filename";]]
	)
)
hl.bind(
	"CTRL + SHIFT + XF86Favorites",
	hl.dsp.exec_cmd(
		[[window="$(hyprctl activewindow -j)" && filename="$(date +%Y%m%d_%H%M%S)_$(echo $window | jq -r .class).png" && filepath="$HOME/Pictures/Screenshots/$filename" && still -c "grim -g \"\$(slurp -d)\" \"$filepath\""; test -f "$filepath" && notify-send --urgency=low --icon="$filepath" "Screenshot region saved as: $filename"]]
	)
)

-- Screenrecord
hl.bind(
	"ALT + XF86Favorites",
	hl.dsp.exec_cmd([[uwsm app -- ]] .. CONF_DIR .. [[/scripts/screen-record.sh true false]])
)
hl.bind(
	"ALT + SHIFT + XF86Favorites",
	hl.dsp.exec_cmd([[uwsm app -- ]] .. CONF_DIR .. [[/scripts/screen-record.sh true true]])
)
hl.bind(
	"ALT + CTRL + XF86Favorites",
	hl.dsp.exec_cmd([[uwsm app -- ]] .. CONF_DIR .. [[/scripts/screen-record.sh false false]])
)
hl.bind(
	"ALT + CTRL + SHIFT + XF86Favorites",
	hl.dsp.exec_cmd([[uwsm app -- ]] .. CONF_DIR .. [[/scripts/screen-record.sh false true]])
)

-- Change wallpaper
hl.bind(MAINMOD .. " + ALT + W", hl.dsp.exec_cmd(WALLPAPER_GEN))

-- Touchpad toggle keybind. Shared state (touchpad_enabled) and set_touchpad live in
-- variables.lua, since the fullscreen rule in rules.lua also drives the touchpad.
local function toggle_touchpad()
	set_touchpad(not touchpad_enabled)
	hl.exec_cmd(
		[[notify-send --category=device --urgency=low "Touchpad ]]
			.. (touchpad_enabled and "Enabled" or "Disabled")
			.. [["]]
	)
end
hl.bind("XF86TouchpadToggle", toggle_touchpad, { locked = true, submap_universal = true })

-- Rotate screen (was scripts/screen-rotate.sh, which referenced the now-removed $transform);
-- re-applies the eDP-1 monitor with a new transform. Keep params in sync with display.lua.
local function rotate_screen(transform)
	hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1.25, transform = transform })
end
hl.bind("ALT + " .. MAINMOD .. " + up", function()
	rotate_screen(0)
end) -- normal
hl.bind("ALT + " .. MAINMOD .. " + left", function()
	rotate_screen(1)
end) -- 90°
hl.bind("ALT + " .. MAINMOD .. " + right", function()
	rotate_screen(3)
end) -- 270°
hl.bind("ALT + " .. MAINMOD .. " + down", function()
	rotate_screen(2)
end) -- 180°

-- Magnification (was hyprctl getoption | jq round-trips)
local function zoom(factor)
	hl.config({ cursor = { zoom_factor = math.max(1, hl.get_config("cursor.zoom_factor") * factor) } })
end
hl.bind(MAINMOD .. " + equal", function()
	zoom(1.1)
end, { repeating = true })
hl.bind(MAINMOD .. " + minus", function()
	zoom(0.9)
end, { repeating = true })
hl.bind(MAINMOD .. " + KP_ADD", function()
	zoom(1.1)
end, { repeating = true })
hl.bind(MAINMOD .. " + KP_SUBTRACT", function()
	zoom(0.9)
end, { repeating = true })
hl.bind(MAINMOD .. " + SHIFT + minus", function()
	hl.config({ cursor = { zoom_factor = 1 } })
end)
hl.bind(MAINMOD .. " + SHIFT + KP_SUBTRACT", function()
	hl.config({ cursor = { zoom_factor = 1 } })
end)
