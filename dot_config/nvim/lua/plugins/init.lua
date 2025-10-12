return {

	{
		{ import = "plugins.ai" },
	},

	-- Provides syntax highlighting for generic log files in VIM.
	{ "MTDL9/vim-log-highlighting" },

	{
		"windwp/nvim-ts-autotag",
		lazy = false,
		config = function()
			require("nvim-ts-autotag").setup({
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
				did_setup = true,
				get_opts = true,
				setup = true,

				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				per_filetype = {
					["jsx"] = {
						enable_close = true,
					},
				},
			})
		end,
	}, -- autoclose tags

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	}, -- autoclose parens, brackets, quotes, etc...
	{
		-- detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},
	{
		-- Powerful Git integration for Vim
		"tpope/vim-fugitive",
	},
	{
		-- GitHub integration for vim-fugitive
		"tpope/vim-rhubarb",
	},

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	}, -- add, delete, change surroundings (it's awesome)

	{
		"nacro90/numb.nvim",
		lazy = false,
		opts = {},
	}, ---Peeking the buffer while entering command :{number}

	{
		"laytan/cloak.nvim",
		config = function()
			require("cloak").setup({
				enabled = true,
				cloak_character = "*",
				-- The applied highlight group (colors) on the cloaking, see `:h highlight`.
				highlight_group = "Comment",
				patterns = {
					{
						-- Match any file starting with ".env".
						-- This can be a table to match multiple file patterns.
						file_pattern = {
							".env*",
							"wrangler.toml",
							".dev.vars",
						},
						-- Match an equals sign and any character after it.
						-- This can also be a table of patterns to cloak,
						-- example: cloak_pattern = { ":.+", "-.+" } for yaml files.
						cloak_pattern = "=.+",
					},
				},
			})
		end,
	},

	-- undotree
	{
		"mbbill/undotree",
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle),
	},

	-- clipboard access
	{
		"ojroques/nvim-osc52", -- allows copying text and setting system clipboard
		event = { "BufReadPre", "BufNewFile" },
	},

	-- todo comments
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local todo_comments = require("todo-comments")

			-- set keymaps
			local keymap = vim.keymap -- for conciseness

			keymap.set("n", "]t", function()
				todo_comments.jump_next()
			end, { desc = "Next todo comment" })

			keymap.set("n", "[t", function()
				todo_comments.jump_prev()
			end, { desc = "Previous todo comment" })

			todo_comments.setup()
		end,
	},

	-- twilight
	{
		"folke/twilight.nvim",
		opts = {
			dimming = {
				alpha = 0.25, -- amount of dimming
				-- we try to get the foreground from the highlight groups or fallback color
				color = { "Normal", "#ffffff" },
				term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
				inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
			},
			context = 10, -- amount of lines we will try to show around the current line
			treesitter = true, -- use treesitter when available for the filetype
			-- treesitter is used to automatically expand the visible text,
			-- but you can further control the types of nodes that should always be fully expanded
			expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
				"function",
				"method",
				"table",
				"if_statement",
			},
			exclude = {}, -- exclude these filetypes
		},
	},

	{ "wakatime/vim-wakatime", lazy = false },
}
