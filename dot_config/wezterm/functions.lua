local wezterm = require("wezterm")
local M = {}

-- Custom tab bar
-- From https://fredrikaverpil.github.io/blog/2024/10/20/session-management-in-wezterm-without-tmux/
local function get_current_working_dir(tab)
	local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = "" }
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	return current_dir == HOME_DIR and "." or string.gsub(current_dir.file_path, "(.*[/\\])(.*)", "%2")
end

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	local cwd = wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Text = get_current_working_dir(tab_info) },
	})

	return cwd
end

local function custom_tab(tab, tabs, panes, config, hover, max_width)
	local has_unseen_output = false
	local zoomed = ""
	if not tab.is_active then
		for _, pane in ipairs(tab.panes) do
			if pane.has_unseen_output then
				has_unseen_output = true
				break
			end
		end
	end

	if tab.active_pane.is_zoomed then
		zoomed = "[+]"
	end

	local cwd = tab_title(tab)
	local title = string.format(" [%s]%s %s ", tab.tab_index + 1, zoomed, cwd)

	if has_unseen_output then
		return {
			{ Foreground = { Color = "#8866bb" } },
			{ Text = title },
		}
	end

	return {
		{ Text = title },
	}
end

-- Function for the right status bar
local function right_status(window, _)
	window:set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		-- { Background = { Color = "#588E6E" } },
		{ Foreground = { Color = "#A6C833" } },
		{ Text = " > " .. window:active_workspace() .. " | " .. wezterm.hostname() },
	}))
end

M.custom_tab = custom_tab
M.right_status = right_status

return M
