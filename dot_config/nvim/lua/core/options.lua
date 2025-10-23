local opt = vim.opt

opt.cmdheight = 1 -- more space for displaying messages
opt.updatetime = 100 -- faster copmletion time
opt.laststatus = 3 -- global statusline
opt.backspace = "indent,eol,start" -- allow backspace on
opt.pumheight = 10 -- pop up menu height
opt.conceallevel = 0 -- so that `` is visible in markdown files

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- undotree settings
vim.g.undotree_WindowLayout = 2

opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkon100"

opt.foldlevel = 99 -- prevent files from auto folding when opened but still allow individual folds with zc and za

-- time in milliseconds to wait for a mapped sequence to complete
opt.timeoutlen = 500

-- interval for writing swap file to disk, also used by gitsigns
-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
opt.updatetime = 250
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- disable tilde on end of buffer: https://github.com/  neovim/neovim/pull/8546#issuecomment-643643758
opt.fillchars = { eob = " " }

--line numbers
opt.relativenumber = true
opt.number = true
opt.nu = true

-- tabs & indentation
opt.numberwidth = 4 -- set number column width to 2 {default 4}
opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
opt.tabstop = 4 -- insert n spaces for a tab
opt.softtabstop = 4 -- Number of spaces that a tab counts for while performing editing operations
opt.expandtab = true -- convert tabs to spaces
opt.smartindent = true
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false

-- opt.whichwrap:append({
-- 	["<"] = true,
-- 	[">"] = true,
-- 	["["] = true,
-- 	["]"] = true,
-- 	h = true,
-- 	l = true,
-- })
vim.o.whichwrap = "bs<>[]hl" -- which "horizontal" keys are allowed to travel to prev/next line

-- opt.list = true
-- opt.listchars = {
--     trail = "·",
--     precedes = "←",
--     extends = "→",
--     nbsp = "+",
--     -- eol = "↲",
-- }

opt.shortmess:append("c") -- don't give |ins-completion-menu| messages
opt.iskeyword:append("-") -- hyphenated words recognized by searches
opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- appearance
opt.termguicolors = true
opt.background = "dark"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
vim.g.clipboard = "osc52"
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.hlsearch = false
opt.incsearch = true

vim.o.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 8 -- minimal number of screen columns either side of cursor if wrap is `false`
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.updatetime = 50
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

opt.previewwindow = true

vim.api.nvim_set_option_value("winblend", 0, { scope = "global" })
