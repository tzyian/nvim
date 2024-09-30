return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	event = "VeryLazy",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	config = function()
		require("barbecue").setup()
		------ Been moved to which-key.lua
		-- vim.keymap.set(
		-- 	"n",
		-- 	"<leader>cb",
		-- 	"<cmd>lua require('barbecue.ui').toggle()<CR>",
		-- 	{ desc = "Toggle breadcrumbs" }
		-- )
	end,
}
