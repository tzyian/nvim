return {
	"michaelb/sniprun",
	lazy = true,
	branch = "master",

	build = "sh install.sh",
	-- do 'sh install.sh 1' if you want to force compile locally
	-- (instead of fetching a binary from the github release). Requires Rust >= 1.65

	opts = {
		interpreter_options = {
			Cpp_original = {
				-- debug template that prints to stdout on any `debug(var1, ...)`
				compiler = "g++ -std=c++23 -O0 -include" .. os.getenv("HOME") .. "/leetcode/debug.hpp"
			}
		}
	},

	keys = {
		{ "<leader>rr", ":SnipRun<CR>",       mode = { "v" }, silent = true,         desc = "Run SnipRun" },
		{
			"<leader>rr",
			function()
				-- Keep cursor position
				local view = vim.fn.winsaveview()
				vim.cmd('%SnipRun')
				vim.api.nvim_echo({ { "Running SnipRun...", "MoreMsg" } }, false, {})
				vim.fn.winrestview(view)
			end,
			desc = "Run SnipRun"
		},
		{ "<leader>rc", "<cmd>SnipClose<CR>", silent = true,  desc = "Close SnipRun" },
		{ "<leader>rR", "<cmd>SnipReset<CR>", silent = true,  desc = "SnipReset" },
	},
}
