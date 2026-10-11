-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

-- Extra monitor configuration
-- internal pocket 3 monitor
hl.monitor({ output = "DSI-1", mode = "preferred", position = "auto", scale = omarchy_monitor_scale, transform = 3 })

-- 1440p DP monitors
hl.monitor({ output = "DP-5", mode = "preferred", position = "auto", scale = 1.25 })
hl.monitor({ output = "DP-6", mode = "preferred", position = "auto", scale = 1.25 })

-- 4K HDMI monitors
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = 2 })
