local wezterm = require("wezterm")

local M = {}

local sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")
sessionizer.config.paths = { "/Users/giygas/Projects/", "/Users/giygas/.config" }

function M.apply_keybinds(config_builder)
	-- Show sessionizer
	table.insert(config_builder.keys, {
		key = "f",
		mods = "CTRL",
		action = sessionizer.show,
	})
end

return M
