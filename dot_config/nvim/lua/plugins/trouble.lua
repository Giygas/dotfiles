return {
	"folke/trouble.nvim",
	opts = {
		modes = {
			symbols = {
				desc = "document symbols",
				mode = "lsp_document_symbols",
				focus = true,
				win = {

					type = "float",
					relative = "editor",
					border = "rounded",
					title = "Symbols",
					title_pos = "center",
					position = { 0, -2 },
					size = { width = 0.4, height = 1 },
					zindex = 200,
				},
			},
			lsp = {
				desc = "definitions",
				mode = "lsp",
				focus = true,
				win = {
					position = "right",
					size = { width = 0.4 },
				},
			},
		}, -- for default options, refer to the configuration section for custom setup.
	},
	cmd = "Trouble",
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle focus=true<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>fs",
			"<cmd>Trouble symbols toggle focus=true<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>fd",
			"<cmd>Trouble lsp toggle <cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>xL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>xQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
}
