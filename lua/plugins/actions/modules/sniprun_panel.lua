local M = { buf = nil, _setup = false }
local ns = vim.api.nvim_create_namespace("sniprun_panel")

function M.ensure_buffer()
	if M.buf and vim.api.nvim_buf_is_valid(M.buf) then
		return M.buf
	end

	M.buf = vim.api.nvim_create_buf(false, true)
	pcall(vim.api.nvim_buf_set_name, M.buf, "[Sniprun Output]")

	vim.bo[M.buf].buftype = "nofile"
	vim.bo[M.buf].bufhidden = "hide"
	vim.bo[M.buf].swapfile = false
	vim.bo[M.buf].buflisted = false
	vim.bo[M.buf].filetype = "log"

	local b = { buffer = M.buf }
	vim.keymap.set("n", "q", M.close_panel, b)
	return M.buf
end

function M.append_output(d)
	d = d or {}
	local buf = M.ensure_buffer()
	local badge = (d.status == "ok") and "✓ OK" or (d.status == "error") and "✗ ERROR" or (d.status or "UNKNOWN"):upper()
	local header = string.format("  [%s]  %s", os.date("%H:%M:%S"), badge)

	local lines = { header }
	if d.message and d.message ~= "" then
		vim.list_extend(lines, vim.split(d.message, "\n", { plain = true }))
	else
		table.insert(lines, "(no output)")
	end
	table.insert(lines, "")

	vim.bo[buf].modifiable = true
	local count = vim.api.nvim_buf_line_count(buf)
	local is_empty = count == 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""
	local start_line = is_empty and 0 or count
	vim.api.nvim_buf_set_lines(buf, is_empty and 0 or -1, -1, false, lines)
	vim.bo[buf].modifiable = false

	-- Header full-width background (filetype=log formats body)
	local bg = (d.status == "ok") and "DiffAdd" or (d.status == "error") and "DiffDelete" or "DiffChange"
	vim.api.nvim_buf_set_extmark(buf, ns, start_line, 0, { line_hl_group = bg, hl_eol = true })

	-- Auto-scroll if open
	local win = vim.fn.bufwinid(buf)
	if win ~= -1 then
		vim.api.nvim_win_set_cursor(win, { vim.api.nvim_buf_line_count(buf), 0 })
	end
end

function M.clear_output()
	if not M.buf or not vim.api.nvim_buf_is_valid(M.buf) then
		return
	end
	vim.bo[M.buf].modifiable = true
	vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, {})
	vim.api.nvim_buf_clear_namespace(M.buf, ns, 0, -1)
	vim.bo[M.buf].modifiable = false
end

function M.close_panel()
	local win = M.buf and vim.fn.bufwinid(M.buf) or -1
	if win ~= -1 then
		vim.api.nvim_win_close(win, true)
	end
end

function M.toggle_panel(width)
	local buf = M.ensure_buffer()
	local win = vim.fn.bufwinid(buf)

	if win ~= -1 then
		vim.api.nvim_win_close(win, true)
	else
		local new_win = vim.api.nvim_open_win(buf, false, {
			split = "right",
			width = width or 48,
		})

		vim.wo[new_win].number = false
		vim.wo[new_win].relativenumber = false
		vim.wo[new_win].wrap = true
		vim.wo[new_win].winfixwidth = true
		vim.wo[new_win].signcolumn = "no"

		vim.api.nvim_win_set_cursor(new_win, { vim.api.nvim_buf_line_count(buf), 0 })
	end
end

function M.setup()
	if M._setup then
		return
	end
	local ok, sa = pcall(require, "sniprun.api")
	if ok then
		sa.register_listener(function(d)
			vim.schedule(function()
				M.append_output(d)
			end)
		end)
		M._setup = true
	end
end

return M
