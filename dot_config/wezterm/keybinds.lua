local w = require("wezterm")
local sessionizer = require("scripts.sessionizer")

return {
	-- Wezterm sessionizer
	-- {
	-- 	key = "f",
	-- 	mods = "CTRL",
	-- 	action = w.action_callback(sessionizer.open),
	-- },
	-- SESSION MANAGEMENT
	-- Attach to muxer
	-- {
	-- 	key = "a",
	-- 	mods = "LEADER",
	-- 	action = w.action.AttachDomain("unix"),
	-- },
	-- Detach from muxer
	-- {
	-- 	key = "d",
	-- 	mods = "LEADER",
	-- 	action = w.action.DetachDomain({ DomainName = "unix" }),
	-- },
	-- Rename current session; analagous to command in tmux
	{
		key = "$",
		mods = "LEADER|SHIFT",
		action = w.action.PromptInputLine({
			description = "Enter new name for session",
			action = w.action_callback(function(window, pane, line)
				if line then
					w.mux.rename_workspace(window:mux_window():get_workspace(), line)
				end
			end),
		}),
	},
	-- Show list of workspaces
	{
		key = "s",
		mods = "LEADER|CTRL",
		action = w.action.ShowLauncherArgs({ flags = "WORKSPACES" }),
	},

	-- Kill Wezterm
	{
		key = "q",
		mods = "CMD",
		action = w.action.QuitApplication,
	},

	-- Debug Overlay
	{
		key = "L",
		mods = "CTRL|SHIFT",
		action = w.action.ShowDebugOverlay,
	},

	-- Split the current pane horizontally
	{
		key = "\\",
		mods = "LEADER",
		action = w.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Split the current pane vertically
	{
		key = "-",
		mods = "LEADER",
		action = w.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Close the current pane
	{
		key = "x",
		mods = "LEADER",
		action = w.action.CloseCurrentPane({ confirm = false }),
	},
	-- Zoom the current pane
	{
		key = "z",
		mods = "LEADER",
		action = w.action.TogglePaneZoomState,
	},

	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = w.action.SendKey({ key = "a", mods = "CTRL" }),
	},
	-- Copy to clipboard
	{
		key = "c",
		mods = "SUPER",
		action = w.action.CopyTo("Clipboard"),
	},
	-- Paste from clipboard
	{
		key = "v",
		mods = "SUPER",
		action = w.action.PasteFrom("Clipboard"),
	},
	-- Close current tab
	{
		key = "w",
		mods = "SUPER",
		action = w.action.CloseCurrentTab({ confirm = true }),
	},
	-- Open new tab
	{
		key = "t",
		mods = "SUPER",
		action = w.action.SpawnTab("CurrentPaneDomain"),
	},
	-- Toggle full screen
	{
		key = "m",
		mods = "LEADER",
		action = w.action.ToggleFullScreen,
	},
	-- Activate Command Palette
	{
		key = "P",
		mods = "CTRL|SHIFT",
		action = w.action.ActivateCommandPalette,
	},
	-- Reload config
	{
		key = "r",
		mods = "CMD|SHIFT",
		action = w.action.ReloadConfiguration,
	},
	-- Char select
	{
		key = "U",
		mods = "CTRL|SHIFT",
		action = w.action.CharSelect,
	},
	-- Rename tab
	{
		key = ",",
		mods = "LEADER",
		action = w.action.PromptInputLine({
			description = "Enter new name for tab",
			action = w.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	-- Tab navigator
	{
		key = "w",
		mods = "LEADER",
		action = w.action.ShowTabNavigator,
	},
	-- Next and previous tab
	{
		key = "l",
		mods = "LEADER",
		action = w.action.ActivateTabRelative(1),
	},
	{
		key = "h",
		mods = "LEADER",
		action = w.action.ActivateTabRelative(-1),
	},

	-- Go to tab by index
	{ key = "1", mods = "LEADER", action = w.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = w.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = w.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = w.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = w.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = w.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = w.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = w.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = w.action({ ActivateTab = 8 }) },

	-- Swap panes
	{
		key = "{",
		mods = "LEADER|SHIFT",
		action = w.action.PaneSelect({ mode = "SwapWithActiveKeepFocus" }),
	},

	-- Move tab
	{ key = "1", mods = "LEADER|ALT", action = w.action({ MoveTab = 0 }) },
	{ key = "2", mods = "LEADER|ALT", action = w.action({ MoveTab = 1 }) },
	{ key = "3", mods = "LEADER|ALT", action = w.action({ MoveTab = 2 }) },
	{ key = "4", mods = "LEADER|ALT", action = w.action({ MoveTab = 3 }) },
	{ key = "5", mods = "LEADER|ALT", action = w.action({ MoveTab = 4 }) },
}
