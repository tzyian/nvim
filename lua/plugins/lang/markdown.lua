return {
	-- {
	-- 	"epwalsh/obsidian.nvim",
	-- 	version = "*", -- recommended, use latest release instead of latest commit
	-- 	lazy = true,
	-- 	ft = "markdown",
	-- 	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- 	-- event = {
	-- 	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	-- 	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	-- 	--   -- refer to `:h file-pattern` for more examples
	-- 	--   "BufReadPre path/to/my-vault/*.md",
	-- 	--   "BufNewFile path/to/my-vault/*.md",
	-- 	-- },
	-- 	dependencies = {
	-- 		-- Required.
	-- 		"nvim-lua/plenary.nvim",
	--
	-- 		-- see below for full list of optional dependencies 👇
	-- 	},
	-- 	opts = {
	-- 		workspaces = {
	-- 			{
	-- 				name = "personal",
	-- 				path = "/mnt/c/Users/Ian/Documents/Obsidian Vault",
	-- 			},
	-- 		},
	--
	-- 		-- see below for full list of options 👇
	-- 	},
	-- },
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require('render-markdown').setup({
				completions = { lsp = { enabled = true } },
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		-- Load on specific command or file opening
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_open_to_the_world = 1

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					vim.keymap.set("n", "<leader>pp", "<cmd>MarkdownPreview<CR>", {
						buffer = true,
						silent = true,
						desc = "Markdown Preview",
					})
				end,
			})
		end,
	},
}
