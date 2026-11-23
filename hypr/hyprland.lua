require("config.monitors")
require("config.autostart")
require("config.environment")
require("config.ui")
require("config.devices")
require("config.keybindings")
require("config.core")

-- Noctalia dynamic color scheme hook (applies active theme borders and styles)
local ok, noctalia = pcall(require, "noctalia")
if ok and noctalia.apply_theme then
    noctalia.apply_theme()
end
