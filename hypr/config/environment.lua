-- Cursor sizing (standard 24px for 1080p Wayland)
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Wayland Toolkit compatibility
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- GTK & Qt scaling (Hyprland handles fractional scaling; keep framework scale at 1 to prevent double-scaling)
hl.env("GDK_SCALE", "1")
hl.env("GDK_DPI_SCALE", "1")
hl.env("QT_SCALE_FACTOR", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- GTK rendering backend
hl.env("GSK_RENDERER", "cairo")

-- Hybrid Graphics / Hardware Video Acceleration:
-- Run Hyprland and desktop decoding on Intel TigerLake Iris Xe (iHD driver) for stability & battery life.
hl.env("LIBVA_DRIVER_NAME", "iHD")
-- To run demanding games or 3D apps on NVIDIA GeForce MX350, use: prime-run <command>
