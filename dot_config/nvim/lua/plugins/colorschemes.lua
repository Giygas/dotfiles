return {
	-- COLOR SCHEMES
	{
		"olivercederborg/poimandres.nvim",
		name = "poimandres",
		lazy = true, -- change to false if primary
		priority = 100,
		opts = {
			bold_vert_split = false, -- use bold vertical separators
			dim_nc_background = true, -- dim 'non-current' window backgrounds
			disable_background = true, -- disable background
			disable_float_background = false, -- disable background for floats
			disable_italics = false, -- disable italics
		},
	},

	{
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.everforest_enable_italic = true
			vim.cmd.colorscheme("everforest")
		end,
	},

	{
		"bluz71/vim-nightfly-colors",
		name = "nightfly",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.nightflyTransparent = true
		end,
	},

	{
		"vague2k/vague.nvim",
		-- lazy = false, -- make sure we load this during startup if it is your main colorscheme
		-- priority = 1000, -- make sure to load this before all the other plugins
		opts = {
			transparent = true,
		},
	},

	{
		{
			"webhooked/kanso.nvim",
			-- lazy = false,
			-- priority = 1000,
			opts = {
				transparent = true,
			},
		},
	},

	{ "savq/melange-nvim" },

	{
		"metalelf0/black-metal-theme-neovim",
		name = "black-metal",
		lazy = false,
		priority = 1000,
		opts = {
			-- Can be one of: bathory | burzum | dark-funeral | darkthrone | emperor | gorgoroth | immortal | impaled-nazarene | khold | marduk | mayhem | nile | taake | thyrfing | venom | windir
			theme = "emperor",
			-- Can be one of: 'light' | 'dark', or set via vim.o.background
			variant = "dark",
			transparent = true,
		},
	},

	{
		"craftzdog/solarized-osaka.nvim",
		name = "osaka",
		-- lazy = true,
		-- priority = 1000,
		-- opts = {
		-- 	transparent = true,
		-- },
	},

	{

		"shaunsingh/nord.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- Example config in lua
			vim.g.nord_contrast = true -- Make sidebars and popup menus like nvim-tree and telescope have a different background
			vim.g.nord_borders = false -- Enable the border between verticaly split windows visable
			vim.g.nord_disable_background = true -- Disable the setting of background color so that NeoVim can use your terminal background
			vim.g.set_cursorline_transparent = false -- Set the cursorline transparent/visible
			vim.g.nord_italic = false -- enables/disables italics
			vim.g.nord_enable_sidebar_background = false -- Re-enables the background of the sidebar if you disabled the background of everything
			vim.g.nord_uniform_diff_background = true -- enables/disables colorful backgrounds when used in diff mode
			vim.g.nord_bold = false -- enables/disables bold
		end,
	},

	{
		"bettervim/yugen.nvim",
		name = "yugen",
	},

	{
		"datsfilipe/vesper.nvim",
		lazy = false,
		priority = 1000,
		opts = { transparent = true },
	},

	{
		"jwbaldwin/oscura.nvim",
		name = "oscura",
		lazy = true,
		opts = {
			transparent_background = true,
			nvim_tree_darker = true,
		},
	},

	{
		"ficcdaf/ashen.nvim",
		name = "ashen",
		lazy = true,
		opts = {
			transparent = true,
		},
	},

	{
		"everviolet/nvim",
		name = "evergarden",
		priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
		opts = {
			theme = {
				variant = "fall", -- 'winter'|'fall'|'spring'|'summer'
				accent = "green",
			},
			editor = {
				transparent_background = true,
				sign = { color = "none" },
				-- float = {
				-- 	color = "mantle",
				-- 	solid_border = false,
				-- },
				-- completion = {
				-- 	solid_border = false,
				-- 	color = "surface0",
				--19 },
			},
			style = {
				tabline = { "reverse" },
				search = { "italic", "reverse" },
				incsearch = { "italic", "reverse" },
				types = { "italic" },
				keyword = { "italic" },
				comment = { "italic" },
			},
		},
	},

	{
		"catppuccin/nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				term_colors = true,
				flavour = "mocha",
				transparent_background = true,
			})

			vim.cmd([[colorscheme catppuccin]])
		end,
	},

	{
		"gmr458/cold.nvim",
		name = "cold",
		lazy = true,
		build = ":ColdCompile",
		opts = {
			transparent_background = true,
			styles = {
				floats = "transparent",
			},
		},
	},

	{ -- wait for a transparent version
		"ronisbr/nano-theme.nvim",
		name = "nano",
		init = function()
			vim.o.background = "dark"
		end,
	},

	{
		"fcancelinha/nordern.nvim",
		name = "nordern",
		branch = "master",
		priority = 1000,
		opts = {
			brighter_comments = true,
			italic_comments = true,
			transparent = true,
			transparent_background = true,
		},
	},

	{
		"aliqyan-21/darkvoid.nvim",
		opts = {
			transparent = true,
			transparent_background = true,
			glow = true,
		},
	},

	{
		"HoNamDuong/hybrid.nvim",
		lazy = true,
		opts = { transparent = true },
	},

	{
		"AlexvZyl/nordic.nvim",
		lazy = true,
		opts = {
			transparent = {
				bg = true,
				float = false,
			},
		},
	},

	{
		"rmehri01/onenord.nvim",
		lazy = true,
		opts = {
			borders = true,
			styles = {
				comments = "italic",
				keywords = "bold",
				functions = "italic,bold",
				variables = "NONE",
				sidebars = "dark",
				floats = "dark",
			},
			disable = {
				background = true,
				float_background = false,
			},
		},
	},

	{
		"ramojus/mellifluous.nvim",
		lazy = true,
		opts = {
			transparent_background = { enabled = true },
		},
	},

	{
		"EdenEast/nightfox.nvim",
		-- Terafox, Dawnfox, Dayfox, Nordfox, Duskfox, and Nightfox
		opts = {
			options = {
				styles = {
					floats = "transparent",
				},
				transparent = true,
			},
		},
	},
}
