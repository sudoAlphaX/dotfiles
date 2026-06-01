-- https://wiki.hyprland.org/Configuring/Variables/#input
hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		numlock_by_default = true,

		follow_mouse = 2,
		natural_scroll = false,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			disable_while_typing = true,
			natural_scroll = true,
			middle_button_emulation = true,
			tap_button_map = "lrm",
			clickfinger_behavior = true,
			tap_to_click = true,
			tap_and_drag = true,
		},

		float_switch_override_focus = 0,
	},

	-- https://wiki.hyprland.org/Configuring/Variables/#gestures
	gestures = {
		workspace_swipe_invert = true,
		workspace_swipe_forever = true, -- don't clamp at neighbouring workspace
		workspace_swipe_cancel_ratio = 0.35,
		workspace_swipe_create_new = true,
		workspace_swipe_direction_lock = true,
		workspace_swipe_direction_lock_threshold = 75,
	},

	cursor = {
		inactive_timeout = 10,
		hide_on_key_press = true,
		hide_on_touch = true,
		persistent_warps = true,
		warp_on_change_workspace = 1,
		sync_gsettings_theme = true,
	},

	binds = {
		workspace_center_on = 1,
		allow_workspace_cycles = true,
		hide_special_on_workspace_change = true,
	},
})

-- Example per-device config
-- See https://wiki.hyprland.org/Configuring/Devices/ for more
-- hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

hl.device({
	name = TOUCHPAD_DEVICE,
	enabled = true,
})
