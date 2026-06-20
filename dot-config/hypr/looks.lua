hl.config({
	-- https://wiki.hyprland.org/Configuring/Variables/#general
	general = {
		gaps_in = 2,
		gaps_out = 5,

		border_size = 3,

		["col.active_border"] = { colors = { "rgba(f38ba8ff)", "rgba(cba6f7ff)" }, angle = 45 },
		["col.inactive_border"] = "rgba(595959aa)",

		resize_on_border = true,
		extend_border_grab_area = 12,

		allow_tearing = false,

		layout = "dwindle",

		snap = {
			enabled = true,
			window_gap = 25,
			monitor_gap = 10,
		},
	},

	-- https://wiki.hyprland.org/Configuring/Variables/#decoration
	decoration = {
		rounding = 10,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		-- https://wiki.hyprland.org/Configuring/Variables/#blur
		blur = {
			enabled = true,
			passes = 1,
			xray = false,
			popups = false,
			vibrancy = 0.1696,
		},

		-- https://wiki.hyprland.org/Configuring/Variables/#shadow
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
	},

	-- https://wiki.hyprland.org/Configuring/Variables/#animations
	animations = {
		enabled = true,
	},

	render = {
		direct_scanout = 2,
		expand_undersized_textures = false,
	},

	-- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
	dwindle = {
		preserve_split = true, -- You probably want this
		smart_resizing = false,
		force_split = 2,
		use_active_for_splits = true,
	},

	-- https://wiki.hyprland.org/Configuring/Variables/#misc
	misc = {
		force_default_wallpaper = -1,
		animate_manual_resizes = true,
		disable_hyprland_logo = false,
		focus_on_activate = true,
		mouse_move_focuses_monitor = false,
		close_special_on_empty = true,
		key_press_enables_dpms = true,
		anr_missed_pings = 5,
		session_lock_xray = true,
	},

	xwayland = {
		use_nearest_neighbor = true,
		force_zero_scaling = true,
	},

	ecosystem = {
		enforce_permissions = true,
	},
})

-- Animation curves (bezier: name, two control points)
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

-- Animation tree: hl.animation({ leaf, enabled, speed, bezier|spring[, style] })
-- NOTE: the curve is named via `bezier =` (or `spring =`), NOT `curve =`. The wiki still
-- shows `curve =`, but Hyprland 0.55.2's handler only reads leaf/enabled/speed/bezier/spring/style.
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })
hl.animation({
	leaf = "specialWorkspace",
	enabled = true,
	speed = 6.5,
	bezier = "myBezier",
	style = "slidefadevert -100%",
})
