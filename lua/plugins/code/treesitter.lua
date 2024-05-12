return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- lazy = false,
		event = { "BufRead", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
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
}
