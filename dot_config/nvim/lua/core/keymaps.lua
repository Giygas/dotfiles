local keymap = vim.keymap

---------------------
-- General Keymaps (Run On Init)
---------------------
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

keymap.set("i", "<C-c>", "<Esc>")

-- keymap.set("n", "Q", "<nop>")
-- keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- keymap.set("n", "<leader><leader>", function()
-- 	vim.cmd("so")
-- end)

----------------------
-- Plugin Keymaps
----------------------
-- Toggle diagnostics
local diagnostics_active = true

vim.keymap.set("n", "<leader>do", function()
	diagnostics_active = not diagnostics_active

	if diagnostics_active then
		vim.diagnostic.enable(false)
	else
		vim.diagnostic.enable(true)
	end
end)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Save and load session
vim.keymap.set("n", "<leader>SS", ":mksession! .session.vim<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>SL", ":source .session.vim<CR>", { noremap = true, silent = false })

-- Noice keymaps
-- vim.keymap.set("n", "<leader>nl", function()
-- 	require("noice").cmd("last")
-- end, { desc = "Show last notification" })
--
-- vim.keymap.set("n", "<leader>nn", ":Notifications<CR>", { desc = "Show all notifications" })

---------------------
-- Lsp On Attach Keymaps (Run only when LSP is running)
---------------------
-- local lsp_on_attach = function(bufnr)
-- 	-- keymap options
-- 	local opts = { noremap = true, silent = true, buffer = bufnr }
--
-- 	-- set keymaps
-- 	-- keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references
-- 	-- keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
-- 	-- keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts) -- go to definition
-- 	-- keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
-- 	-- keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
-- 	-- keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
-- 	-- keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
-- 	-- keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
-- 	-- keymap.set("n", "<leader>sd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
-- 	-- keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts) -- show diagnostics for cursor
-- 	-- keymap.set("n", "<leader>]d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
-- 	-- keymap.set("n", "<leader>[d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
-- 	-- keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
-- 	-- keymap.set("n", "<leader>so", "<cmd>Lspsaga outline<CR>", opts) -- see outline on right hand side
-- end
