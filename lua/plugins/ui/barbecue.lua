return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	config = function()
		require("barbecue").setup()
		vim.keymap.set(
			"n",
			"<leader>cb",
			"<cmd>lua require('barbecue.ui').toggle()<CR>",
			{ desc = "Toggle breadcrumbs" }
		)
	end,
}
