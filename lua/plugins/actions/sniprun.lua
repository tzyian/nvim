return {
	"michaelb/sniprun",
	lazy = true,
	branch = "master",

	build = "sh install.sh",
	-- do 'sh install.sh 1' if you want to force compile locally
	-- (instead of fetching a binary from the github release). Requires Rust >= 1.65

	opts = {
	},

	keys = {
		{ "<leader>rr", ":SnipRun<CR>",   mode = { "v" }, silent = true,              desc = "Run SnipRun" },
		{ "<leader>rc", ":SnipClose<CR>", silent = true,  desc = "Close SnipRun" },
		{ "<leader>rr", ":%SnipRun<CR>",  silent = true,  desc = "SnipRun whole file" },
	},
}
