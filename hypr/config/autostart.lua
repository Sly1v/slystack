hl.on("hyprland.start", function()
	-- Systemd & D-Bus environment synchronization
	hl.exec_cmd(
		"dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP HYPRLAND_INSTANCE_SIGNATURE"
	)
	hl.exec_cmd(
		"systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP HYPRLAND_INSTANCE_SIGNATURE"
	)
	-- Restart desktop portal for proper screen sharing & file pickers
	hl.exec_cmd("systemctl --user restart xdg-desktop-portal-hyprland.service xdg-desktop-portal.service")
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets,pkcs11,ssh")

	-- Launch Noctalia Desktop Shell (also manages wallpaper via noctalia/config.toml)
	hl.exec_cmd("noctalia")

	-- Optional: launch hyprpaper wallpaper daemon if not using Noctalia's wallpaper manager
	-- hl.exec_cmd("hyprpaper")
end)
