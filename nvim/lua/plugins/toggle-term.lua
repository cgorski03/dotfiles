-- lua/plugins/toggleterm.lua

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		-- Calculate integer dimensions for floating window based on current window size
		local float_width = math.floor(vim.o.columns * 0.4)
		local float_height = math.floor(vim.o.lines * 0.4)

		require("toggleterm").setup({
			direction = "float", -- Default direction for the *first* time any terminal opens
			open_mapping = [[<c-\>]], -- The direct <C-\> mapping for the default terminal

			float_opts = {
				border = "curved",
				width = float_width,
				height = float_height,
				winblend = 3,
			},

			lazygit = "lazygit",
		})

		-- Define your preferred vertical width here
		local vertical_size = 80

		-- === General Toggling (Remembers Last State) - NO 't' Prefix ===
		-- These simply toggle the terminal. If you opened it floating, it will open floating.
		-- If you opened it vertically, it will open vertically.
		-- Removed `<leader>t` binding for the default terminal.
		vim.keymap.set("n", "<leader>1", "<cmd>ToggleTerm 1<CR>", { desc = "Toggle Terminal 1" })
		vim.keymap.set("n", "<leader>cd", function()
			local Terminal = require("toggleterm.terminal").Terminal
			local current_dir = vim.fn.expand("%:p:h")

			if vim.fn.isdirectory(current_dir) == 1 then
				local term = Terminal:new({
					dir = current_dir,
					direction = "float",
				})
				term:toggle()
			else
				vim.notify("Directory does not exist: " .. current_dir, vim.log.levels.WARN)
			end
		end, { desc = "Open Terminal in Current File's Directory" })
	end,
}
