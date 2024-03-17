return {
	{
		"ellisonleao/glow.nvim",
		event = "VeryLazy",
		cmd = "Glow",
		config = function()
			require("glow").setup({})
			vim.keymap.set("n", "<leader>!g", "<cmd>Glow<CR>", { silent = true })
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_open_to_the_world = 1
			-- vim.g.mkdp_browser = "wslview"
			vim.keymap.set("n", "<leader>!p", "<cmd>MarkdownPreview<CR>", { silent = true })
		end,
		ft = { "markdown" },
	},
}
