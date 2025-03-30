-- import telescope plugin safely
local telescope_status, telescope = pcall(require, "telescope")
if not telescope_status then
	print("telescope did not load")
	return
end

-- import telescope actions safely
local actions_status, actions = pcall(require, "telescope.actions")
if not actions_status then
	print("telescope actions did not load")
	return
end

-- configure telescope
telescope.setup({
	-- configure custom mappings
	defaults = {
		file_ignore_patterns = { "node_modules" },
		path_display = { "truncate" }, -- hidden, tail, absolute, smart, shorten, truncate (truncate can = a number like "truncate = 3")
		preview = {
			treesitter = false, -- Disable treesitter in the preview window so large files don't hang
			filesize_limit = 0.1,
			timeout = 250,
		},
	},
	pickers = {
		buffers = {
			initial_mode = "normal",
			sort_mru = true, -- sort by last open buffer
			mappings = {
				n = {
					["d"] = actions.delete_buffer,
				},
			},
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

-- load fzf exension for faster searching
telescope.load_extension("fzf")
telescope.load_extension("ui-select")

-- Primeagen's telescope setup
local keymap = vim.keymap
local builtin = require("telescope.builtin")
keymap.set("n", "<leader>pws", function()
	local word = vim.fn.expand("<cword>")
	builtin.grep_string({ search = word })
end)
keymap.set("n", "<leader>pWs", function()
	local word = vim.fn.expand("<cWORD>")
	builtin.grep_string({ search = word })
end)
keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
