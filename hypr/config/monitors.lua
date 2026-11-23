-- Hardware-tailored display profile for Dell Laptop (1920x1080)
-- Primary display: eDP-1 (1080p @ 60Hz with 1.5x fractional scale)
hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60.02",
	position = "0x0",
	scale = 1.5,
})

-- Dynamic fallback for any connected external monitor (HDMI / USB-C / DisplayPort)
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto-right",
	scale = 1,
})

-- Bind persistent workspaces 1-10 to the primary display
for w = 1, 10 do
	hl.workspace_rule({
		workspace = tostring(w),
		monitor = "eDP-1",
		default = (w == 1),
		persistent = true,
	})
end
