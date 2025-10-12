return {
	{ "L3MON4D3/LuaSnip", keys = {} },
	{ "xzbdmw/colorful-menu.nvim" },
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "*",
		opts = {
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "normal",
				kind_icons = {
					Text = "󰉿",
					Method = "m",
					Function = "󰊕",
					Constructor = "",
					Field = "",
					Variable = "󰆧",
					Class = "󰌗",
					Interface = "",
					Module = "",
					Property = "",
					Unit = "",
					Value = "󰎠",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰇽",
					Struct = "",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "󰊄",
				},
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					cmdline = {
						min_keyword_length = 2,
					},

					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
			keymap = {
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-y>"] = { "accept", "fallback" },
				["<C-.>"] = { "show", "fallback" },
			},
			cmdline = {
				enabled = false,
				completion = { menu = { auto_show = true } },
				keymap = {
					["<C-y>"] = { "accept_and_enter", "fallback" },
					["<C-j>"] = { "select_next", "fallback" },
					["<C-k>"] = { "select_prev", "fallback" },
				},
			},
			completion = {
				keyword = {
					range = "prefix",
				},
				list = {
					selection = {
						preselect = true,
						auto_insert = false,
					},
				},
				accept = {
					auto_brackets = {
						enabled = true,
						override_brackets_for_filetypes = {
							tex = { "{", "}" },
						},
					},
				},
				menu = {
					min_width = 20,
					border = "rounded",
					draw = {
						-- We don't need label_description now because label and label_description are already
						-- combined together in label by colorful-menu.nvim.
						columns = { { "kind_icon" }, { "label", gap = 1 }, { "source_name" } },
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
				documentation = {
					-- window = {
					-- 	border = "rounded",
					-- 	scrollbar = false,
					-- 	winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
					-- },
					auto_show = true,
					auto_show_delay_ms = 500,
					update_delay_ms = 50,
					window = {
						max_width = math.min(80, vim.o.columns),
						border = "rounded",
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
