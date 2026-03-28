local w = require("wezterm")

local function smart_scroll(direction)
	return w.action_callback(function(win, pane)
		local proc = pane:get_foreground_process_name() or ""
		if proc:find("tmux") then
			-- Send escape sequence so tmux handles it
			local seq = direction == "up" and "\x1b[5;2~" or "\x1b[6;2~"
			win:perform_action(w.action.SendString(seq), pane)
		else
			win:perform_action(direction == "up" and w.action.ScrollByPage(-1) or w.action.ScrollByPage(1), pane)
		end
	end)
end

return {
	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = w.action.QuickSelectArgs,
	},
	{
		key = "x",
		mods = "CTRL|SHIFT",
		action = w.action.ActivateCopyMode,
	},

	-- Increase font size
	{
		key = "=",
		mods = "CTRL",
		action = w.action.IncreaseFontSize,
	},
	-- Decrease font size
	{
		key = "-",
		mods = "CTRL",
		action = w.action.DecreaseFontSize,
	},
	-- Reset font size
	{
		key = "0",
		mods = "CTRL",
		action = w.action.ResetFontSize,
	},

	-- PageUp and PageDown for terminal scrolling
	{ key = "PageUp", mods = "SHIFT", action = smart_scroll("up") },
	{ key = "PageDown", mods = "SHIFT", action = smart_scroll("down") },

	-- {
	-- 	key = "f",
	-- 	mods = "CTRL",
	-- 	action = w.action.SpawnCommandInNewWindow({
	-- 		args = { "./tmux-sessionizer" },
	-- 		cwd = "/Users/giygas/.local/scripts",
	-- 		domain = "DefaultDomain",
	-- 		position = {
	-- 			x = 10,
	-- 			y = 300,
	-- 		},
	-- 	}),
	-- },

	-- { key = "c", mods = "SHIFT|CTRL", action = w.action.QuickSelect },

	-- -- Rename current session; analagous to command in tmux
	-- {
	-- 	key = "$",
	-- 	mods = "LEADER|SHIFT",
	-- 	action = w.action.PromptInputLine({
	-- 		description = "Enter new name for session",
	-- 		action = w.action_callback(function(window, pane, line)
	-- 			if line then
	-- 				w.mux.rename_workspace(window:mux_window():get_workspace(), line)
	-- 			end
	-- 		end),
	-- 	}),
	-- },
	-- -- Show list of workspaces
	-- {
	-- 	key = "s",
	-- 	mods = "LEADER|CTRL",
	-- 	action = w.action.ShowLauncherArgs({ flags = "WORKSPACES" }),
	-- },
	--
	-- Kill Wezterm
	{
		key = "q",
		mods = "CMD",
		action = w.action.QuitApplication,
	},

	-- Debug Overlay
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = w.action.ShowDebugOverlay,
	},

	-- -- Split the current pane horizontally
	{
		key = "|",
		mods = "LEADER",
		action = w.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- -- Split the current pane vertically
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
	-- -- Toggle full screen
	-- {
	-- 	key = "m",
	-- 	mods = "LEADER",
	-- 	action = w.action.ToggleFullScreen,
	-- },
	-- Activate Command Palette
	{
		key = "P",
		mods = "CTRL|SHIFT",
		action = w.action.ActivateCommandPalette,
	},
	-- Reload config
	{
		key = "R",
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
	-- {
	-- 	key = "w",
	-- 	mods = "LEADER",
	-- 	action = w.action.ShowTabNavigator,
	-- },
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
