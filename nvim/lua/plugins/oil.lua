return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
		{
			"<leader>-",
			function()
				require("oil").open_float()
			end,
			desc = "Open Oil in a float",
		},
		{
			"<leader>r",
			function()
				require("oil").open(vim.fn.getcwd())
			end,
			desc = "Open Oil at project root",
		},
	},
	opts = {
		default_file_explorer = true,
		columns = {
			"icon",
		},
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,
		constrain_cursor = "editable",
		win_options = {
			signcolumn = "yes:2",
		},
		lsp_file_methods = {
			enabled = true,
			timeout_ms = 1000,
			autosave_changes = true,
		},
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
			["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in a new tab" },
			-- ["<C-p>"] = "actions.preview",
			-- ["<C-c>"] = "actions.close",
			["q"] = "actions.close",
			["<C-l>"] = "actions.refresh",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["g."] = "actions.toggle_hidden",
			["g\\"] = "actions.toggle_trash",
		},
		-- Configuration for the floating window (e.g. when calling oil.open_float)
		float = {
			padding = 2,
			max_width = 80,
			max_height = 20,
			border = "rounded",
			win_options = {
				signcolumn = "yes:2",
				winblend = 0,
			},
		},
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = true,
			is_hidden_file = function(name, bufnr)
				return vim.startswith(name, ".")
			end,
			-- This function defines what will never be shown, even when `show_hidden` is set
			is_always_hidden = function(name, bufnr)
				return name == ".." or name == ".git"
			end,
			natural_order = true,
			sort = {
				{ "type", "asc" },
				{ "name", "asc" },
			},
		},
	},
}
