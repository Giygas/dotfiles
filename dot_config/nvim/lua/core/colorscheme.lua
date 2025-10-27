function ColorMyPencils(color)
	color = color or "evergarden"
	vim.termguicolors = color
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

	-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000000" })

	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
	-- vim.cmd([[hi NvimTreeNormal guibg=NONE]])

	-- vim.cmd([[
	--   highlight DiffAdd guibg=#3c4841 guifg=#ffffff
	--   highlight DiffDelete guibg=#514045 guifg=#ffffff
	--   highlight DiffChange guibg=#3A515D guifg=#ffffff
	--   highlight DiffText guibg=#3a5f5f guifg=#ffffff
	-- ]])
end

ColorMyPencils("catppuccin")
