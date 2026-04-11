-- vi:set filetype=lua
-- Generated with wallust

local config = {}

config.colors = {
	cursor_bg = "{{ foreground }}",
	cursor_border = "{{ foreground }}",
	background = "{{ background }}",
	foreground = "{{ foreground }}",

	ansi = {
		"{{ color0 }}",
		"{{ color1 }}",
		"{{ color2 }}",
		"{{ color1 }}",
		"{{ color3 }}",
		"{{ color5 }}",
		"{{ color6 }}",
		"{{ color7 }}",
	},

	brights = {
		"{{ color8 }}",
		"{{ color9 }}",
		"{{ color10 }}",
		"{{ color11 }}",
		"{{ color1 }}",
		"{{ color13 }}",
		"{{ color14 }}",
		"{{ color15 }}",
	},
}

return config
