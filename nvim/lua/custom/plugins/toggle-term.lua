return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			direction = "float",
			open_mapping = [[<c-\>]],

			float_opts = {
				border = "curved",
				width = math.floor(vim.o.columns * 0.8),
				height = math.floor(vim.o.lines * 0.8),
				winblend = 3,
			},

			lazygit = "lazygit",
		})

		-- Your keymaps remain the same
		vim.keymap.set("n", "<leader>tg", "<cmd>ToggleTerm<CR>", { desc = "Toggle default terminal" })
		vim.keymap.set("n", "<leader>1", "<cmd>ToggleTerm 1<CR>", { desc = "Toggle Terminal 1" })
		vim.keymap.set("n", "<leader>2", "<cmd>ToggleTerm 2<CR>", { desc = "Toggle Terminal 2" })
		vim.keymap.set("n", "<leader>tl", "<cmd>ToggleTerm lazygit<CR>", { desc = "Toggle Lazygit" })

		vim.keymap.set("n", "<leader>lv", function()
			vim.cmd("ToggleTerm size=80 direction=vertical lazygit")
		end, { desc = "Toggle Lazygit (Vertical)" })
	end,
}
