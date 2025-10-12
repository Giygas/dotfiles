vim.lsp.enable({
	"gopls",
	"lua_ls",
	"pylsp",
	"yamlls",
	"html",
	"vue_ls",
	"marksman",
	"emmet_language_server",
	"ts_ls",
	"svelte",
	"tailwindcss",
})

vim.diagnostic.config({
	-- virtual_lines = true,
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

-- vim.lsp.config("pylsp", {
-- 	settings = {
-- 		pylsp = {
-- 			signature = {
-- 				formatter = "ruff",
-- 			},
-- 		},
-- 	},
-- })
