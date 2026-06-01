-- Environment variables
hl.env("DESKTOP_SESSION", "Hyprland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Electron set wayland
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-- Cursors
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "24")

-- QT Themes
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- GTK Themes
hl.env("GTK_THEME", "catppuccin-mocha-mauve-standard+default")

HOME = os.getenv("HOME")
CONF_DIR = (os.getenv("XDG_CONFIG_HOME") or HOME .. "/.config") .. "/hypr"

-- Keybind modifier (used in keybinds.lua and rules.lua)
MAINMOD = "SUPER"

-- uwsm helpers
UWSM_APP = "uwsm app -- "
UWSM_APP_S = "uwsm app -s s -- "
UWSM_APP_B = "uwsm app -s b -- "
UWSM_APP_A = "uwsm app -s a -- "
UWSM_SERVICE_S = 'uwsm app -s s -t service -p "Restart=on-failure" -- '
UWSM_SERVICE_B = 'uwsm app -s b -t service -p "Restart=on-failure" -- '

-- Terminal
TERMINAL_COMMAND = "alacritty"
TERMINAL = "systemd-run --user --slice=app-graphical.slice --collect --scope -- " .. TERMINAL_COMMAND

function terminal(prog)
	local id = prog:match("^%S+")
	return "uwsm app -a " .. id .. " -- " .. TERMINAL_COMMAND .. " -e " .. prog
end

function tmux(prog, session)
	local name = session or prog:match("^%S+")
	return "uwsm app -a "
		.. name
		.. " -- "
		.. TERMINAL_COMMAND
		.. " -e uwsm app -s tmux.slice -- tmux new-session -As "
		.. name
		.. " "
		.. prog
end

-- Application (single-use launchers are called inline at their bind/rule site)
FILEMANAGER_APP = "yazi"
CALCULATOR_APP = "qalc"

-- Devices (touchpad name shared by input.lua, the touchpad toggle in keybinds.lua, and the fullscreen rule in rules.lua)
TOUCHPAD_DEVICE = "elan06fa:00-04f3:327e-touchpad"
-- Keyboard backlight (brightnessctl device), used by the fullscreen + SafeEyes rules in rules.lua
KBD_BACKLIGHT = "platform::kbd_backlight"

-- Utilities
POWERMENU = HOME .. "/.config/rofi/scripts/powermenu_t1"
DELAY_START = CONF_DIR .. "/scripts/delay-start.sh"
DELAY_ONLINE = CONF_DIR .. "/scripts/wait-online.sh && " -- carries trailing " && " for inline chaining
ICONS_PATH = HOME .. "/.config/dunst/icons"
-- WALLPAPER_GEN kept (repetitive: used by both the autostart and the change-wallpaper bind)
WALLPAPER_GEN =
	[[killall hyprpaper; ln -sf "$(fd . $HOME/Pictures/Wallpapers -d 1 -e png | shuf -n 1)" "$XDG_RUNTIME_DIR/hyprpaper-gen.png" & systemd-run --user --slice=session-graphical.slice --collect --scope -- hyprpaper]]

---------------------- Functions ----------------------

local waybar_queue = {}
local waybar_done = false
hl.on("layer.opened", function(layer)
	if waybar_done or layer.namespace ~= "waybar" then
		return
	end
	waybar_done = true
	for _, cmd in ipairs(waybar_queue) do
		hl.exec_cmd(cmd)
	end
end)

function after_waybar(cmd)
	table.insert(waybar_queue, cmd)
end

function after_app(process, cmd, delay)
	local wait = DELAY_START .. " " .. process
	if delay ~= nil then
		wait = wait .. " " .. delay
	end
	hl.exec_cmd(wait .. " && " .. cmd)
end

-- Some autostarted apps (e.g. vesktop, librewolf) grab focus when they open and ignore the
-- silent exec rule, because uwsm launches them in a detached systemd scope so Hyprland never
-- associates the window with the spawning PID. The first time such an app becomes the active
-- window, send focus to `return_workspace` (where your real working window lives, e.g. the ws2
-- terminal). One-shot per class, so focusing the app yourself later is unaffected.
-- NOTE: matches on w.class, not w.initialClass — the Lua event window object exposes class
-- (initialClass is nil here); for these apps the two are identical.
-- NOTE: this returns to a fixed workspace rather than focus({ last })/focuscurrentorlast,
-- because during the boot storm the *last* focused window is usually another silent autostart
-- app (e.g. nvtop on special:s7), so focus({ last }) lands there instead of your terminal.
function unfocus_on_appear(initial_class, return_workspace)
	local done = false
	hl.on("window.active", function(w)
		if done or w == nil or w.class ~= initial_class then
			return
		end
		done = true
		hl.dispatch(hl.dsp.focus({ workspace = return_workspace or 2 }))
	end)
end

-- Touchpad enable/disable state, shared by the XF86TouchpadToggle keybind (keybinds.lua) and
-- the fullscreen rule (rules.lua) that disables the touchpad while a window is fullscreen.
touchpad_enabled = true
function set_touchpad(enabled)
	touchpad_enabled = enabled
	hl.device({ name = TOUCHPAD_DEVICE, enabled = enabled })
end

-- Window lock shared state: the SHIFT+ALT+l keybind (keybinds.lua) arms windowlock_addr and
-- holds a systemd idle inhibitor; the window.active rule (rules.lua) locks the session and
-- disarms when focus leaves that window. windowlock_disarm releases the inhibitor.
WINDOWLOCK_INHIBIT = "hypr-windowlock-armed"
windowlock_addr = nil
function windowlock_disarm()
	windowlock_addr = nil
	hl.exec_cmd("pkill -f 'systemd-inhibit .*" .. WINDOWLOCK_INHIBIT .. "'")
end
