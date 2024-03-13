return {
	"michaelb/sniprun",
	event = "VeryLazy",
	branch = "master",

	build = "sh install.sh",
	-- do 'sh install.sh 1' if you want to force compile locally
	-- (instead of fetching a binary from the github release). Requires Rust >= 1.65

	config = function()
		require("sniprun").setup({
			-- your options
		})

		vim.keymap.set({ "n", "v" }, "<leader>rl", ":SnipRun<CR>", { silent = true, desc = "Run SnipRun" })

		vim.keymap.set({ "n", "v" }, "<leader>rc", ":SnipClose<CR>", { silent = true, desc = "Close SnipRun" })

		vim.keymap.set({ "n", "v" }, "<leader>rr", ":%SnipRun<CR>", { silent = true, desc = "SnipRun whole file" })
	end,
}
