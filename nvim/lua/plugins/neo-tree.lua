return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({ toggle = true, reveal = true })
			end,
			desc = "Explorer NeoTree (reveal)",
		},
	},
	opts = {
		window = {
			width = 30, -- Set a custom width for the file explorer
			mappings = {
				["<space>"] = "none", -- Disable the space key for now if you like
			},
		},
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = true,
			},
		},
	},
}
