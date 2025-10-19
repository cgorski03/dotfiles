local M = {} -- This table will hold the functions we want to export

-- Function to open resolved type definition in a new buffer
function M.show_resolved_type_in_buffer()
	local bufnr = vim.api.nvim_get_current_buf()
	local lnum = vim.api.nvim_get_current_win_cursor()[1] - 1
	local col = vim.api.nvim_get_current_win_cursor()[2]

	vim.lsp.buf.hover(bufnr, { bufnr = bufnr, lnum = lnum, col = col }, function(err, result, ctx)
		if err then
			vim.notify("LSP Hover error: " .. err, vim.log.ERROR)
			return
		end
		if result and result.contents then
			local content_lines = {}
			local filetype = "text" -- Default filetype

			-- Handle different content formats from LSP
			if type(result.contents) == "table" then
				if result.contents.kind == "markdown" then
					content_lines = vim.split(result.contents.value, "\n")
					filetype = "markdown" -- Set filetype for markdown
				elseif result.contents.kind == "plaintext" then
					content_lines = vim.split(result.contents.value, "\n")
				else
					-- Fallback for other kinds of tables, try to stringify
					content_lines = vim.split(tostring(result.contents.value or ""), "\n")
				end
			elseif type(result.contents) == "string" then
				content_lines = vim.split(result.contents, "\n")
			else
				content_lines = { "Could not parse hover content." }
			end

			if #content_lines == 0 then
				content_lines = { "No hover information found for this element." }
			end

			-- Create a new scratch buffer
			local new_buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_option(new_buf, "buftype", "nofile")
			vim.api.nvim_buf_set_option(new_buf, "bufhidden", "wipe") -- Close when hidden
			vim.api.nvim_buf_set_option(new_buf, "swapfile", false)
			vim.api.nvim_buf_set_option(new_buf, "modifiable", false) -- Make read-only
			-- Get the word under the cursor for the buffer name
			local current_word = vim.fn.expand("<cword>")
			vim.api.nvim_buf_set_name(new_buf, "[LSP Hover] " .. (current_word ~= "" and current_word or "Selection"))

			-- Set the filetype. If it's markdown, syntax highlighting will work.
			-- For code blocks within markdown, they will also be highlighted.
			vim.api.nvim_buf_set_option(new_buf, "filetype", filetype)

			-- Open a new window to display the buffer
			-- Use 'vsplit' to open vertically on the right, or 'split' for horizontal
			vim.cmd("vsplit")
			vim.api.nvim_set_current_buf(new_buf)

			-- Populate the buffer with content
			vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, content_lines)
		else
			vim.notify("No hover information available.", vim.log.INFO)
		end
	end)
end

return M -- This is crucial: return the table with your functions
