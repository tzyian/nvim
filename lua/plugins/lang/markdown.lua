return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		event = "BufRead *.md",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("render-markdown").setup({})
		end,
	},
	{
		"ellisonleao/glow.nvim",
		event = "BufRead *.md",
		cmd = "Glow",
		opts = {},
		keys = {
			{ "<leader>pg", "<cmd>Glow<CR>", silent = true, desc = "Glow" },
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		event = "BufRead *.md",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_open_to_the_world = 1
			-- vim.g.mkdp_browser = "wslview"
		end,
		ft = { "markdown" },
		keys = {
			{ "<leader>pp", "<cmd>MarkdownPreview<CR>", silent = true, desc = "Markdown Preview" },
		},
	},
}
