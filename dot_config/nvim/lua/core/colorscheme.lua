function ColorMyPencils(color)
	color = color or "evergarden"
	vim.termguicolors = color
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#3c3836" })
	-- vim.cmd([[hi NvimTreeNormal guibg=NONE]])
end

ColorMyPencils("vesper")
