return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- lazy = false,
		event = { "BufRead", "BufNewFile" },
		-- dependencies = {
		-- 	"nvim-treesitter/nvim-treesitter-textobjects",
		-- },
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = { "bash", "c", "html", "lua", "markdown", "vim", "vimdoc" },
				auto_install = true,
				highlight = {
					enable = true,
					disable = { "latex" },
				},
				indent = { enable = true },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							-- ["af"] = "@function.outer",
							-- ["if"] = "@function.inner",
							-- ["ac"] = "@class.outer",
							-- ["ic"] = "@class.inner",
						},

						include_surrounding_whitespace = false,
					},
					swap = {
						enable = true,
						swap_previous = {
							["<leader><Left>"] = "@parameter.inner",
							-- ["<leader><Up>"] = "@parameter.inner",
						},
						swap_next = {
							-- ["<leader><Down>"] = "@parameter.inner",
							["<leader><Right>"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},
}
