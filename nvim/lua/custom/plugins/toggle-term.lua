-- lua/plugins/toggleterm.lua

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		-- Calculate integer dimensions for floating window based on current window size
		local float_width = math.floor(vim.o.columns * 0.8)
		local float_height = math.floor(vim.o.lines * 0.8)

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
		vim.keymap.set("n", "<leader>1", "<cmd>ToggleTerm 1<CR>", { desc = "Toggle Terminal 1 (remembers state)" })
		vim.keymap.set("n", "<leader>2", "<cmd>ToggleTerm 2<CR>", { desc = "Toggle Terminal 2 (remembers state)" })
		vim.keymap.set("n", "<leader>3", "<cmd>ToggleTerm 3<CR>", { desc = "Toggle Terminal 3 (remembers state)" })
		vim.keymap.set("n", "<leader>4", "<cmd>ToggleTerm 4<CR>", { desc = "Toggle Terminal 4 (remembers state)" })
		vim.keymap.set(
			"n",
			"<leader>l", -- Changed lazygit to <leader>l for consistency with others
			"<cmd>ToggleTerm lazygit<CR>",
			{ desc = "Toggle Lazygit (remembers state)" }
		)

		-- === Explicit Vertical Toggles (Always Vertical) - Prefixed with <leader>tv ===
		vim.keymap.set("n", "<leader>tv1", function()
			vim.cmd("ToggleTerm size=" .. vertical_size .. " direction=vertical 1")
		end, { desc = "Terminal 1 (Vertical Split)" })

		vim.keymap.set("n", "<leader>tv2", function()
			vim.cmd("ToggleTerm size=" .. vertical_size .. " direction=vertical 2")
		end, { desc = "Terminal 2 (Vertical Split)" })

		vim.keymap.set("n", "<leader>tv3", function()
			vim.cmd("ToggleTerm size=" .. vertical_size .. " direction=vertical 3")
		end, { desc = "Terminal 3 (Vertical Split)" })

		vim.keymap.set("n", "<leader>tv4", function()
			vim.cmd("ToggleTerm size=" .. vertical_size .. " direction=vertical 4")
		end, { desc = "Terminal 4 (Vertical Split)" })

		vim.keymap.set("n", "<leader>tvl", function()
			vim.cmd("ToggleTerm size=" .. vertical_size .. " direction=vertical lazygit")
		end, { desc = "Lazygit (Vertical Split)" })

		-- === Explicit Float Toggles (Always Floating) - Prefixed with <leader>tf ===
		vim.keymap.set("n", "<leader>tf1", function()
			vim.cmd("ToggleTerm direction=float " .. "width=" .. float_width .. " height=" .. float_height .. " 1")
		end, { desc = "Terminal 1 (Floating)" })

		vim.keymap.set("n", "<leader>tf2", function()
			vim.cmd("ToggleTerm direction=float " .. "width=" .. float_width .. " height=" .. float_height .. " 2")
		end, { desc = "Terminal 2 (Floating)" })

		vim.keymap.set("n", "<leader>tf3", function()
			vim.cmd("ToggleTerm direction=float " .. "width=" .. float_width .. " height=" .. float_height .. " 3")
		end, { desc = "Terminal 3 (Floating)" })

		vim.keymap.set("n", "<leader>tf4", function()
			vim.cmd("ToggleTerm direction=float " .. "width=" .. float_width .. " height=" .. float_height .. " 4")
		end, { desc = "Terminal 4 (Floating)" })

		vim.keymap.set("n", "<leader>tfl", function()
			vim.cmd(
				"ToggleTerm direction=float " .. "width=" .. float_width .. " height=" .. float_height .. " lazygit"
			)
		end, { desc = "Lazygit (Floating)" })

		-- === Close All Terminals ===
		vim.keymap.set("n", "<leader>tt", function()
			-- Close all terminals by sending exit command to each terminal
			local terminals = require("toggleterm.terminal")
			for i = 1, 4 do
				local term = terminals.get(i)
				if term and term:is_open() then
					term:close()
				end
			end
			-- Close lazygit terminal if open
			local lazygit_term = terminals.get("lazygit")
			if lazygit_term and lazygit_term:is_open() then
				lazygit_term:close()
			end
		end, { desc = "Close All Terminals" })
	end,
}
