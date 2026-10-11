-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Applications
o.bind("SUPER + ALT + CTRL + RETURN", "Terminal", 'uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)"')

-- Lock screen. Replaces Omarchy's default Super+L workspace-layout toggle.
hl.unbind("SUPER + L")
o.bind("SUPER + L", "Lock system", "omarchy-system-lock")

-- Screenshots
o.bind("ALT + SHIFT + S", "Screenshot", "omarchy-capture-screenshot")
o.bind("SUPER + ALT + CTRL + O", "Extract text (OCR) from screenshot", "omarchy-capture-text")

-- Window close/layout/state: use Omarchy 4's hl.dsp helpers for Hyprland dispatchers.
o.bind("SUPER + ALT + CTRL + Q", "Close active window", hl.dsp.window.close())
-- o.bind("SUPER + ALT + CTRL + J", "Toggle window split", hl.dsp.layout("togglesplit"))
o.bind("SUPER + ALT + CTRL + P", "Pseudo window", hl.dsp.window.pseudo())
o.bind("SUPER + ALT + CTRL + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

-- Focus using Super+Alt+Ctrl+W/A/S/D. Replaces weather and calendar.
hl.unbind("SUPER + CTRL + ALT + W")
hl.unbind("SUPER + CTRL + ALT + D")
o.bind("SUPER + ALT + CTRL + A", "Move focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + ALT + CTRL + D", "Move focus right", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + ALT + CTRL + W", "Move focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + ALT + CTRL + S", "Move focus down", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces and move windows to workspaces.
-- Use keycodes 10..19 as in Omarchy's own tiling bindings.
for workspace = 1, 10 do
	local key = "code:" .. tostring(workspace + 9)
	o.bind(
		"SUPER + ALT + CTRL + " .. key,
		"Switch to workspace " .. workspace,
		hl.dsp.focus({ workspace = tostring(workspace) })
	)
	o.bind(
		"SUPER + ALT + CTRL + SHIFT + " .. key,
		"Move window to workspace " .. workspace,
		hl.dsp.window.move({ workspace = tostring(workspace) })
	)
end

-- Swap the active window with an adjacent window.
o.bind("SUPER + SHIFT + ALT + CTRL + LEFT", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + ALT + CTRL + RIGHT", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))
o.bind("SUPER + SHIFT + ALT + CTRL + UP", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + ALT + CTRL + DOWN", "Swap window down", hl.dsp.window.swap({ direction = "d" }))

-- Resize active window. code:20 is minus and code:21 is equal on the standard key row.
o.bind("SUPER + ALT + CTRL + code:20", "Expand window left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
o.bind("SUPER + ALT + CTRL + code:21", "Shrink window left", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
o.bind(
	"SUPER + SHIFT + ALT + CTRL + code:20",
	"Shrink window up",
	hl.dsp.window.resize({ x = 0, y = -100, relative = true })
)
o.bind(
	"SUPER + SHIFT + ALT + CTRL + code:21",
	"Expand window down",
	hl.dsp.window.resize({ x = 0, y = 100, relative = true })
)

-- Scroll through workspaces with Super+Alt+Ctrl+mouse wheel.
o.bind("SUPER + ALT + CTRL + mouse_down", "Scroll active workspace forward", hl.dsp.focus({ workspace = "e+1" }))
o.bind("SUPER + ALT + CTRL + mouse_up", "Scroll active workspace backward", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with Super+Alt+Ctrl + mouse buttons.
o.bind("SUPER + ALT + CTRL + mouse:272", "Move window", hl.dsp.window.drag(), { mouse = true })
o.bind("SUPER + ALT + CTRL + mouse:273", "Resize window", hl.dsp.window.resize(), { mouse = true })

-- Window grouping.
o.bind("SUPER + ALT + CTRL + G", "Toggle window grouping", hl.dsp.group.toggle())
o.bind("SUPER + SHIFT + ALT + CTRL + G", "Move active window out of group", hl.dsp.window.move({ out_of_group = true }))
o.bind("SUPER + ALT + CTRL + LEFT", "Move window to group on the left", hl.dsp.window.move({ into_group = "l" }))
o.bind("SUPER + ALT + CTRL + RIGHT", "Move window to group on the right", hl.dsp.window.move({ into_group = "r" }))
o.bind("SUPER + ALT + CTRL + UP", "Move window to group on top", hl.dsp.window.move({ into_group = "u" }))
o.bind("SUPER + ALT + CTRL + DOWN", "Move window to group on bottom", hl.dsp.window.move({ into_group = "d" }))

-- Cycle within a group using E / Shift+E.
-- The old A/D group-cycle bindings conflicted with the custom A/D focus bindings.
o.bind("SUPER + ALT + CTRL + E", "Next window in group", hl.dsp.group.next())
o.bind("SUPER + SHIFT + ALT + CTRL + E", "Previous window in group", hl.dsp.group.prev())
-- Omarchy defaults already provide grouped-window focus on Super+Ctrl+Left/Right;
-- avoid duplicating those bindings here.

-- Lid switch: add touchscreen handling alongside Omarchy's own lid handlers.
-- o.bind(
-- 	"switch:off:Lid Switch",
-- 	"Enable touchscreen on lid open",
-- 	"hyprctl keyword input:touchdevice:enabled true",
-- 	{ locked = true }
-- )
-- o.bind(
-- 	"switch:on:Lid Switch",
-- 	"Disable touchscreen on lid close",
-- 	"hyprctl keyword input:touchdevice:enabled false",
-- 	{ locked = true }
-- )
--

local touchscreen = "gxtp7380:00-27c6:0113"

o.bind("switch:on:Lid Switch", "Disable touchscreen on lid close", function()
	hl.device({ name = touchscreen, enabled = false })
end, { locked = true })

o.bind("switch:off:Lid Switch", "Enable touchscreen on lid open", function()
	hl.device({ name = touchscreen, enabled = true })
end, { locked = true })
