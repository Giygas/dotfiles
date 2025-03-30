local keymap = vim.keymap

---------------------
-- General Keymaps (Run On Init)
---------------------
local init = function()
	vim.g.mapleader = " "
	-- vim.g.bulitin_lsp = true

	keymap.set("n", "<leader>pv", vim.cmd.Ex)

	keymap.set("v", "J", ":m '>+1<CR>gv=gv")
	keymap.set("v", "K", ":m '<-2<CR>gv=gv")

	keymap.set("n", "J", "mzJ`z")
	keymap.set("n", "<C-d>", "<C-d>zz")
	keymap.set("n", "<C-u>", "<C-u>zz")
	keymap.set("n", "n", "nzzzv")
	keymap.set("n", "N", "Nzzzv")

	-- use jk to exit insert mode
	keymap.set("i", "jk", "<ESC>")

	-- delete single character without copying into register
	keymap.set("n", "x", '"_x')

	-- window management
	keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
	keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
	keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

	-- greatest remap ever
	keymap.set("x", "<leader>p", [["_dP]])

	-- next greatest remap ever : asbjornHaland
	keymap.set({ "n", "v" }, "<leader>y", [["+y]])
	keymap.set("n", "<leader>Y", [["+Y]])

	keymap.set({ "n", "v" }, "<leader>d", [["_d]])

	-- This is going to get me cancelled
	keymap.set("i", "<C-c>", "<Esc>")

	keymap.set("n", "Q", "<nop>")
	-- keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

	keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
	keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

	keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
	keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

	keymap.set("n", "<leader><leader>", function()
		vim.cmd("so")
	end)
end

----------------------
-- Plugin Keymaps
----------------------
local plugins = function()
	-- Nvimtree
	keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

	-- Telescope
	keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" }) -- find files within current working directory, respects .gitignore
	keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" }) -- find string in current working directory as you type
	keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" }) -- find string under cursor in current working directory
	keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find existing buffers" }) -- list open buffers in current neovim instance
	keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "[F]ind [H]elp tags" }) -- list available help tags
	keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
	keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
	keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Find Keymaps" }) -- keymaps

	-- Diagnostic keymaps
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

	-- telescope git commands (not on youtube nvim video)
	keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
	keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
	keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
	keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

	-- git signs
	keymap.set("n", "<leader>gl", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Git Line" }) -- toggles git line blame
	keymap.set("n", "]c", "<cmd>Gitsigns next_hunk<CR>", { desc = "Hunk Next" }) -- navigate to next git hunk
	keymap.set("n", "[c", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Hunk Previous" }) -- navigate to previous git hunk
	keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Git Preview (Hunk)" }) -- toggles git hunk preview
	keymap.set("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Hunk Starge" }) -- stage git hunk
	keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Hunk Reset" }) -- reset git hunk
	keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Hunk Undo" }) -- undo git stage hunk
end

---------------------
-- Lsp On Attach Keymaps (Run only when LSP is running)
---------------------
local lsp_on_attach = function(bufnr)
	-- keymap options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keymaps
	-- keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references
	-- keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	-- keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts) -- go to definition
	-- keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	-- keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	-- keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	-- keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	-- keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	-- keymap.set("n", "<leader>sd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	-- keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts) -- show diagnostics for cursor
	-- keymap.set("n", "<leader>]d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	-- keymap.set("n", "<leader>[d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	-- keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	-- keymap.set("n", "<leader>so", "<cmd>Lspsaga outline<CR>", opts) -- see outline on right hand side
end

return {
	init = init,
	plugins = plugins,
	lsp_on_attach = lsp_on_attach,
}
