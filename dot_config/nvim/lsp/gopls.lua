---@type vim.lsp.Config
return {
	cmd = { "gopls" },
	vim.lsp.config("gopls", {
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
					shadow = true,
				},
				staticcheck = true,
			},
		},
		on_attach = function(client, bufnr)
			-- Detach gopls from non-file buffers (like diffview://)
			local uri = vim.uri_from_bufnr(bufnr)
			if not uri:match("^file://") then
				vim.schedule(function()
					vim.lsp.buf_detach_client(bufnr, client.id)
				end)
			end
		end,
	}),
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = {
		"go.work",
		"go.mod",
		".git",
	},
}
