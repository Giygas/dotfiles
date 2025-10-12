return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			image = { enabled = true },
			input = { enabled = false },
			picker = { enabled = false },
			explorer = { enabled = false },
			notifier = { enabled = true, timeout = 2000 },
			scope = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false },
			lazygit = {
				configure = true,
				-- extra configuration for lazygit that will be merged with the default
				-- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
				-- you need to double quote it: `"\"test\""`
				config = {
					os = { editPreset = "nvim-remote" },
					gui = {
						-- set to an empty string "" to disable icons
						nerdFontsVersion = "3",
					},
				},
				-- Theme for lazygit
				theme = {
					[241] = { fg = "Special" },
					activeBorderColor = { fg = "MatchParen", bold = true },
					cherryPickedCommitBgColor = { fg = "Identifier" },
					cherryPickedCommitFgColor = { fg = "Function" },
					defaultFgColor = { fg = "Normal" },
					defaultBgColor = { bg = "None" },
					inactiveBorderColor = { fg = "FloatBorder" },
					optionsTextColor = { fg = "Function" },
					searchingActiveBorderColor = { fg = "MatchParen", bold = true },
					selectedLineBgColor = { bg = "Visual" }, -- set to `default` to have no background colour
					unstagedChangesColor = { fg = "DiagnosticError" },
				},
				win = {
					style = "lazygit",
				},
			},
		},
		keys = {
			{
				"<leader>z",
				function()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},

			{
				"<leader>lg",
				function()
					Snacks.lazygit()
				end,
				desc = "Toggle Zen Mode",
			},
			{
				"<leader>Z",
				function()
					Snacks.zen.zoom()
				end,
				desc = "Toggle Zoom",
			},
			{
				"<leader>n",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
		},
	},
}
