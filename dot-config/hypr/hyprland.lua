-- Naming: snake_case for variables/functions, UPPER_CASE for constants,
-- PascalCase for classes.
-- MAINMOD is SUPER key

require("variables")
require("display")
require("looks")
require("input")
require("keybinds")
require("rules")
require("plugins")
require("gestures")

-- Autostart
hl.on("hyprland.start", function()
	-- System utilities
	hl.exec_cmd(UWSM_SERVICE_S .. "/usr/lib/mate-polkit/polkit-mate-authentication-agent-1")
	hl.exec_cmd(UWSM_SERVICE_S .. "waybar")
	-- after_waybar(UWSM_APP .. "nm-applet")
	hl.exec_cmd(UWSM_SERVICE_B .. "playerctld")
	after_waybar(UWSM_APP_B .. "keepassxc")
	hl.exec_cmd(WALLPAPER_GEN)
	hl.exec_cmd(UWSM_SERVICE_S .. "hypridle")
	hl.exec_cmd(DELAY_ONLINE .. UWSM_SERVICE_B .. "kdeconnectd")
	after_app("kdeconnectd", UWSM_SERVICE_B .. "kdeconnect-indicator")
	after_waybar(UWSM_APP_B .. "safeeyes")
	-- hl.exec_cmd(CONF_DIR .. "/scripts/hypr-portals.sh")
	hl.exec_cmd(UWSM_SERVICE_S .. "dunst")
	hl.exec_cmd(UWSM_SERVICE_S .. "niri-screen-time -daemon")
	-- after_app("dunst", UWSM_SERVICE_B .. "aa-notify -p -f /var/log/audit/audit.log")
	-- after_waybar(UWSM_APP_B .. "warp-taskbar > /dev/null")
	after_waybar(DELAY_ONLINE .. UWSM_APP_B .. "trackma-qt")
	after_waybar(UWSM_SERVICE_B .. "tailscale systray")
	-- after_waybar("command -v opensnitch-ui && while true; do " .. UWSM_APP_B .. "opensnitch-ui && break; done")
	after_waybar(DELAY_ONLINE .. UWSM_SERVICE_B .. "jellyfin-mpv-shim")
	after_app("dunst", UWSM_SERVICE_B .. "btrfs-desktop-notification")
	after_app("dunst", UWSM_SERVICE_B .. "fumon")
	after_waybar(UWSM_SERVICE_B .. "usbguard-qt")
	after_waybar(UWSM_SERVICE_B .. "arch-audit-gtk")
	after_app("dunst", UWSM_APP_S .. "alarm-clock-applet -h")
	-- safeeyes-inhibit.sh replaced by the native window.open/workspace.removed handlers in keybinds.lua
	after_app("vesktop", UWSM_SERVICE_B .. "mprisence")
	hl.exec_cmd(DELAY_ONLINE .. UWSM_SERVICE_B .. "rescrobbled")
	after_app("dunst", UWSM_SERVICE_B .. CONF_DIR .. "/scripts/bluetooth-autoconnect.sh") -- note: now restarts on failure
	-- mpv-touchpad.sh replaced by the native window.fullscreen handler in keybinds.lua
	hl.exec_cmd(UWSM_SERVICE_B .. CONF_DIR .. "/scripts/temperature-notify.sh")
	hl.exec_cmd(UWSM_SERVICE_B .. CONF_DIR .. "/scripts/platform-profile-notify.sh")
	hl.exec_cmd('uwsm app -s s -t service -p "StandardOutput=null" -p "Restart=on-failure" -- ' .. "hyprsunset -i")
	after_app(
		"hyprsunset",
		UWSM_SERVICE_S
			.. 'nerdshade -fixedBedtime "22:00" -fixedWakeup "06:00" -gammaDay 100 -gammaNight 100 -tempDay 6500 -tempNight 4000 -loop -transitionDuration "2h"'
	)

	-- Clipboard management (start after keepassxc for clipboard history removal by kpxc)
	after_app(
		"keepassxc",
		UWSM_SERVICE_B .. "wl-clip-persist --clipboard regular --all-mime-type-regex '^(?!x-kde-passwordManagerHint).+'"
	)
	after_app("keepassxc", UWSM_SERVICE_B .. "wl-paste --type text --watch cliphist store") -- stores only text data

	hl.exec_cmd("cliphist wipe")

	hl.dispatch(hl.dsp.exec_cmd(DELAY_ONLINE .. UWSM_APP .. "librewolf", { workspace = "1 silent" }))
	unfocus_on_appear("librewolf", 2)
	hl.dispatch(hl.dsp.exec_cmd(TERMINAL, { workspace = "2" }))
	hl.dispatch(
		hl.dsp.exec_cmd(DELAY_ONLINE .. UWSM_APP .. "vesktop > /dev/null", { workspace = "special:discord silent" })
	)
	-- hl.dispatch(hl.dsp.exec_cmd(TMUX_OPEN .. " Hyprland", { workspace = "special:s1 silent" }))
	-- hl.dispatch(hl.dsp.exec_cmd(terminal("radeontop -c -T"), { workspace = "special:s6 silent" }))
	hl.dispatch(hl.dsp.exec_cmd(terminal("nvtop -d 15"), { workspace = "special:s7 silent" }))
	hl.dispatch(hl.dsp.exec_cmd(terminal("battop -d 20"), { workspace = "special:s8 silent" }))
	hl.dispatch(hl.dsp.exec_cmd(terminal("btop"), { workspace = "special:s9 silent" }))
	hl.dispatch(hl.dsp.exec_cmd(DELAY_ONLINE .. UWSM_APP_A .. "thunderbird", { workspace = "special:s10 silent" }))

	-- Keep these autostarted apps from stealing focus when they open (uwsm makes the silent
	-- exec rule unreliable — see unfocus_on_appear in variables.lua):
	-- unfocus_on_appear("vesktop", 2)
	-- hl.exec_cmd("node " .. os.getenv("HOME") .. "/.dotfiles/assets/utilities/arrpc/src")
end)

hl.config({
	debug = {
		error_position = 1,
		disable_logs = true,
	},
})
