local wezterm = require("wezterm")
local config = wezterm.config_builder()
local commands = require("commands")
local functions = require("functions")
local colorscheme = require("colorscheme")

-- Colorscheme
config = colorscheme

-- Leader key
config.leader = { key = "b", mods = "CTRL" }

-- Keybinds configuration
local keys = require("keybinds")
config.keys = keys
-- Disable all base keybindings
config.disable_default_key_bindings = true

-- Disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- PLUGINS
-- Smart splits plugin
-- local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
-- smart_splits.apply_to_config(config)

-- local wpr = wezterm.plugin.require("https://github.com/vieitesss/workspacesionizer.wezterm")
--
-- wpr.apply_to_config(config, {
-- 	paths = { "~/Projects/", "~/.config" },
-- 	git_repos = true,
-- 	show = "full",
-- 	binding = {
-- 		key = "f",
-- 		mods = "CTRL",
-- 	},
-- })

-- local wezterm_resurrect = require("config.wezterm_resurrect")
-- wezterm_resurrect.apply_keybinds(config)

-- Config mux domains
config.unix_domains = {
	{
		name = "unix",
	},
}

config.ssh_domains = {
	{
		name = "dev-container",
		remote_address = "192.168.1.10:2222",
		username = "dev",
		multiplexing = "WezTerm",
		assume_shell = "Posix",
		ssh_option = {
			identitiesonly = "yes",
			identityfile = "/Users/giygas/.ssh/id_ed25519",
			forwardagent = "yes",
			forwardx11trusted = "yes",
			forwardx11 = "yes",
			["-X"] = "", -- Enable X11 forwarding
			["-Y"] = "", -- Enable trusted X11 forwarding
			["-o"] = "UserKnownHostsFile=/dev/null,ForwardX11=yes,ForwardX11Trusted=yes",
		},
	},
}

config.mux_enable_ssh_agent = true

-- Tab bar
config.tab_bar_at_bottom = true
config.tab_max_width = 20
config.hide_tab_bar_if_only_one_tab = true
config.switch_to_last_active_tab_when_closing_tab = true
-- config.enable_tab_bar = false

-- Font settings
config.font_size = 16
-- config.font = wezterm.font("JetBrains Mono")
-- config.font = wezterm.font("Hack Nerd Font Mono")
-- config.font = wezterm.font("Consolas")
config.font = wezterm.font("Roboto Mono")
-- config.font = wezterm.font("Fira Code")
-- config.font = wezterm.font("Inconsolata")
-- config.font = wezterm.font("IBM Plex Mono")
-- config.line_height = 1.2

-- Appearance
config.cursor_blink_rate = 0
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.macos_window_background_blur = 30

-- Miscellaneous
config.scrollback_lines = 5000
config.max_fps = 120
config.prefer_egl = true
config.window_close_confirmation = "NeverPrompt"

wezterm.on("augment-command-palette", function()
	return commands
end)

wezterm.on("format-tab-title", functions.custom_tab)

wezterm.on("update-right-status", functions.right_status)

-- -- loads the state whenever I create a new workspace
-- wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
-- 	local workspace_state = resurrect.workspace_state
--
-- 	workspace_state.restore_workspace(resurrect.load_state(label, "workspace"), {
-- 		window = window,
-- 		relative = true,
-- 		restore_text = true,
-- 		on_pane_restore = resurrect.tab_state.default_on_pane_restore,
-- 	})
-- end)
--
-- -- Saves the state whenever I select a workspace
-- wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
-- 	local workspace_state = resurrect.workspace_state
-- 	resurrect.save_state(workspace_state.get_workspace_state())
-- end)

return config
