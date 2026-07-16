return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
	keys = {
		{
			"<leader>gd",
			"<cmd>DiffviewOpen<cr>",
			desc = "Open git diff view",
		},
		{
			"<leader>gD",
			"<cmd>DiffviewClose<cr>",
			desc = "Close git diff view",
		},
		{
			"<leader>gh",
			"<cmd>DiffviewFileHistory %<cr>",
			desc = "Open file history",
		},
	},
	opts = {
		use_icons = vim.g.have_nerd_font,
		view = {
			default = {
				layout = "diff2_horizontal",
			},
		},
	},
}
