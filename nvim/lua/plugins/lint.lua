return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			local javascript_filetypes = {
				javascript = true,
				typescript = true,
				javascriptreact = true,
				typescriptreact = true,
			}

			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				javascript = { "eslint" },
				typescript = { "eslint" },
				javascriptreact = { "eslint" },
				typescriptreact = { "eslint" },
			}

			local function javascript_linter()
				local root = vim.fs.root(0, { "package.json", ".git" })
				local local_oxlint = root and (root .. "/node_modules/.bin/oxlint") or nil
				local local_eslint = root and (root .. "/node_modules/.bin/eslint") or nil

				if local_oxlint and vim.uv.fs_stat(local_oxlint) then
					return "oxlint"
				end

				if vim.fn.executable("oxlint") == 1 then
					return "oxlint"
				end

				if local_eslint and vim.uv.fs_stat(local_eslint) then
					return "eslint"
				end

				return vim.fn.executable("eslint") == 1 and "eslint" or nil
			end

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					if vim.bo.modifiable then
						if javascript_filetypes[vim.bo.filetype] then
							local linter = javascript_linter()
							if linter then
								lint.try_lint(linter)
							end
						else
							lint.try_lint()
						end
					end
				end,
			})
		end,
	},
}
