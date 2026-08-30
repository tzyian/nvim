return {
	"michaelb/sniprun",
	lazy = true,
	branch = "master",
	-- no support for Windows
	enabled = not vim.loop.os_uname().version:match("Windows"),
	build = "sh install.sh",
	-- do 'sh install.sh 1' if you want to force compile locally
	-- (instead of fetching a binary from the github release). Requires Rust >= 1.65

	opts = {
		interpreter_options = {
			Cpp_original = {
				-- debug template that prints to stdout on any `debug(var1, ...)`
				compiler = "g++ -std=c++23 -O0 -g -I "
						.. vim.env.HOME .. "/leetcode -include "
						.. vim.env.HOME .. "/leetcode/debug.hpp",
			}
		},
		display = {
			"Classic",
			"VirtualText",
			-- "VirtualLine",
			-- "TempFloatingWindow",
			-- "LongTempFloatingWindow",
			-- "Terminal",
			-- "TerminalWithCode"
			"Api",
		}
	},

	config = function(_, opts)
		require("sniprun").setup(opts)
		require("plugins.actions.modules.sniprun_panel").setup()
	end,

	keys = function()
		local panel = require("plugins.actions.modules.sniprun_panel")

		return {
			{ "<leader>r", "<Plug>SnipRun", mode = { "v" }, silent = true, desc = "Run SnipRun" },
			{
				"<leader>rr",
				function()
					-- Keep cursor position
					local view = vim.fn.winsaveview()
					local bufnr = vim.api.nvim_get_current_buf()

					-- temporarily change to package main for go files to run whole file
					if vim.bo.filetype == "go" then
						local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
						for i, line in ipairs(lines) do
							if line:match("^%s*package%s+") then
								local target_line_idx = i - 1
								local original_line = line
								vim.api.nvim_buf_set_lines(0, target_line_idx, target_line_idx + 1, false, { "package main" })

								vim.defer_fn(function()
									if vim.api.nvim_buf_is_valid(bufnr) then
										vim.api.nvim_buf_set_lines(bufnr, target_line_idx, target_line_idx + 1, false, { original_line })
									end
								end, 500)
								break
							end
						end
					end

					vim.cmd("%SnipRun")
					vim.api.nvim_echo({ { "Running SnipRun...", "MoreMsg" } }, false, {})
					vim.fn.winrestview(view)
				end,
				desc = "Run SnipRun",
			},
			{
				"<leader>rt",
				function()
					panel.toggle_panel()
				end,
				desc = "Toggle SnipRun Panel",
			},
			{
				"<leader>rc",
				function()
					pcall(vim.cmd, "SnipClose")
					panel.close_panel()
				end,
				silent = true,
				desc = "Close SnipRun",
			},
			{
				"<leader>rx",
				function()
					pcall(vim.cmd, "SnipReset")
					panel.clear_output()
				end,
				silent = true,
				desc = "SnipReset",
			},
		}
	end,
}
