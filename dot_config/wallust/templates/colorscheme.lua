-- vi:set filetype=lua
-- Generated with wallust

local config = {}

config.colors = {
	background = "{{ color1 | darken(0.75)}}",
	foreground = "{{ foreground }}",

	cursor_bg = "{{ color9 }}",
	cursor_fg = "{{ color0 }}",
	cursor_border = "{{ color9 }}",

	selection_fg = "{{ color9 }}",
	selection_bg = "{{ color0 }}",

	scrollbar_thumb = "{{ color1 }}",
	split = "{{ color10 }}",
	-- compose_cursor = "",
	visual_bell = "{{ color11 }}",

	ansi = {
		"{{ color0 }}",
		"{{ color1 }}",
		"{{ color2 }}",
		"{{ color11 }}",
		"{{ color5 }}",
		"{{ color4 }}",
		"{{ color13 }}",
		"{{ color8 }}",
	},

	brights = {
		"{{ color8 }}",
		"{{ color9 }}",
		"{{ color10 }}",
		"{{ color11 }}",
		"{{ color12 }}",
		"{{ color9 | lighten(0.3) }}",
		"{{ color14 | lighten(0.3) }}",
		"{{ color7 }}",
	},

	indexed = {
		[16] = "{{ color3 }}",
	},
}

return config
