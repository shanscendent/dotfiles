-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.default_domain = "WSL:Ubuntu"

config.font = wezterm.font("JetBrainsMono Nerd Font")

function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "GruvboxDarkHard"
	else
		return "GruvboxLight"
	end
end

-- Dynamically set the color scheme
local gui = wezterm.gui
if gui then
	config.color_scheme = scheme_for_appearance(gui.get_appearance())
end

-- and finally, return the configuration to wezterm
return config
