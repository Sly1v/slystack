hl.config({ general = { gaps_in = 5 } })
hl.config({ general = { gaps_out = 10 } })
hl.config({ general = { border_size = 2 } })
hl.config({
	general = {
		col = {
			active_border = {
				colors = { "rgba(E8364Fee)", "rgba(F28A2Eee)" },
				angle = 45,
			},
		},
	},
})
hl.config({ general = { col = { inactive_border = "rgba(2A2E3Daa)" } } })
hl.config({ general = { resize_on_border = true } })
hl.config({ general = { allow_tearing = false } })
hl.config({ general = { layout = "dwindle" } })

hl.config({ decoration = { rounding = 8 } })
hl.config({ decoration = { rounding_power = 2 } })
hl.config({ decoration = { active_opacity = 1.0 } })
hl.config({ decoration = { inactive_opacity = 0.95 } })
hl.config({ decoration = { shadow = { enabled = true } } })
hl.config({ decoration = { shadow = { range = 4 } } })
hl.config({ decoration = { shadow = { render_power = 3 } } })
hl.config({ decoration = { shadow = { color = "rgba(1a1a1aee)" } } })
hl.config({ decoration = { blur = { enabled = true } } })
hl.config({ decoration = { blur = { size = 4 } } })
hl.config({ decoration = { blur = { passes = 4 } } })
hl.config({ decoration = { blur = { vibrancy = 0.1696 } } })

-- Tailored for 1080p screen at 1.5x scale (logical size fits nicely)
hl.window_rule({
	match = { class = "dev.noctalia.Noctalia" },
	float = true,
	size = { 780, 580 },
})
hl.layer_rule({
	name = "noctalia",
	match = { namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$" },
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

hl.config({ animations = { enabled = true } })

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 9, bezier = "quick" })

hl.config({ dwindle = { preserve_split = true } })
hl.config({ master = { new_status = "master" } })
hl.config({ misc = { force_default_wallpaper = -1 } })
hl.config({ misc = { disable_hyprland_logo = true } })
