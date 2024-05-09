return {
	{
		"MeanderingProgrammer/markdown.nvim",
		event = "BufRead *.md",
		name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("render-markdown").setup({})
		end,
	},
	{
		"ellisonleao/glow.nvim",
		lazy = true,
		cmd = "Glow",
		opts = {},
		keys = {
			{ "<leader>pg", "<cmd>Glow<CR>", silent = true, desc = "Glow" },
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		lazy = true,
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
