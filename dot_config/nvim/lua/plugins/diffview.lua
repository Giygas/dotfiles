return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	keys = {
		{ "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Open diff view" },
		{ "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
		{ "<leader>ds", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk in Diffview" },
		{ "<leader>du", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk in Diffview" },
		{ "<leader>df", "<cmd>DiffviewFileHistory %<cr>", desc = "Open file history" },
		{ "<leader>dB", "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>", desc = "Review branch changes" },
	},
	opts = {
		enhanced_diff_hl = true,

		use_icons = true,
		view = {
			default = { layout = "diff2_horizontal" },
			merge_tool = {
				layout = "diff4_mixed",
				disable_diagnostics = true,
			},
		},
	},
}
