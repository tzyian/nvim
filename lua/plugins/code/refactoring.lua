return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	lazy = true,
	keys = {
		{
			"<leader>cR",
			"<cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
			mode = { "n", "x" },
			desc = "Refactor",
		},
	},
	config = function()
		require("refactoring").setup()
	end,
}
