return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,

			formatters_by_ft = {
				-- lua
				lua = { "stylua" },
				-- base web formats (use a sub-list to run only the first available formatter)
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettier", "prettierd", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "marksman", "prettier", stop_after_first = true },
				-- python = { "isort", "black", stop_after_first = true },
				python = { "ruff_format", "ruff_organize_imports" },
				-- svelte
				svelte = { "prettier", stop_after_first = true },
				-- react
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				-- json
				json = { "prettierd", "prettier", stop_after_first = true },
				-- everything else will use lsp format
			},
		},
	},

	-- 	-- Define your formatters
	-- 	-- Set up format-on-save
	-- 	format_on_save = { timeout_ms = 500, lsp_fallback = true },
	-- 	format_after_save = { lsp_format = "fallback" },
	-- },
}
