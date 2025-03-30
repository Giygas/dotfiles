local opt = vim.opt

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
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

-- line wrapping
opt.wrap = false

opt.whichwrap:append({
	["<"] = true,
	[">"] = true,
	["["] = true,
	["]"] = true,
	h = true,
	l = true,
})

-- opt.list = true
-- opt.listchars = {
--     trail = "·",
--     precedes = "←",
--     extends = "→",
--     nbsp = "+",
--     -- eol = "↲",
-- }

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- appearance
opt.termguicolors = true
opt.background = "dark"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")
opt.iskeyword:append("_")

opt.hlsearch = false
opt.incsearch = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.updatetime = 50
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

opt.previewwindow = true
