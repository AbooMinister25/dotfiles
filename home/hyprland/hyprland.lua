-- local smw = require("split-monitor-workspaces")

local terminal = "ghostty"

hl.monitor({
	output = "DP-3",
	mode = "2560x1440@165",
	position = "1080x0",
	scale = 1,
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "preferred",
	position = "0x0",
	transform = 1,
})

hl.workspace_rule({
	workspace = "1",
	monitor = "DP-3",
	default = true
})

hl.config({
	general = {
		gaps_out = 12,
		border_size = 0
	},

	decoration = {
		rounding = 10,
		rounding_power = 4.0,
		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.1696
		},
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
	}
})

hl.env("HYPRCURSOR_THEME", "oblique-cursor")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "oblique-cursor")
hl.env("TERM", terminal)
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("MOZ_ENABLE_WAYLAND", 0)

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpolkitagent")
	hl.exec_cmd("wl-paste --watch cliphist store")
end)

smw.setup({
	workspace_count = 7,
	monitor_priority = { "DP-3", "HDMI-A-1" }
});

local mainMod = "SUPER"
local ipc = "noctalia msg "

-- Desktop navigation
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + X", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + right", smw.cycle_workspaces("next"))
hl.bind(mainMod .. " + left", smw.cycle_workspaces("prev"))

for i = 1, smw.get_amount_of_workspaces() do
	local n = tostring(i)
	hl.bind(mainMod .. " +" .. n, smw.workspace(n))
	hl.bind(mainMod .. " + SHIFT +" .. n, smw.move_to_workspace_silent(n))
end

-- Widgets/Panels
hl.bind(mainMod .. "+ Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. "+ SHIFT + C", hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard"))
hl.bind(mainMod .. "+ SHIFT + S", hl.dsp.exec_cmd(ipc .. "screenshot-annotate"))

hl.config({
	plugin = {
		hyprbars = {
			bar_height = 28,
			bar_text_align = "center",
			bar_title_enabled = true,
			bar_text_size = 12,
			bar_padding = 12,
			bar_button_padding = 8,
			icon_on_hover = true,
			inactive_button_color = "rgb(d1d1d1)",
			bar_buttons_alignment = "left",
			bar_part_of_window = true,
			bar_precedence_over_border = true,
			bar_text_font = "Inter",
			bar_color = "rgba(2c2c2eaa)", -- same color, ~67% opacity
			bar_blur = true,
			bar_text_weight = "bold",
			col = { text = "rgb(a0a0a5)" }
		},
	},
})

hl.plugin.hyprbars.add_button({
	bg_color = "rgb(ff5f57)",
	size = 12,
	icon = "×",
	action = "hyprctl dispatch 'hl.dsp.window.close()'",
	fg_color = "rgb(000000)",
})

hl.plugin.hyprbars.add_button({
	bg_color = "rgb(febc2e)",
	size = 12,
	icon = "–",
	action = "hyprctl dispatch movetoworkspacesilent special:minimized",
	fg_color = "rgb(000000)",
})

hl.plugin.hyprbars.add_button({
	bg_color = "rgb(28c840)",
	fg_color = "rgb(000000)",
	size = 12,
	icon = "+",
	action = "hyprctl dispatch 'hl.dsp.window.fullscreen()'",
})

hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
	},
	no_anim = true,
	blur = true,
	blur_popups = true,
})
