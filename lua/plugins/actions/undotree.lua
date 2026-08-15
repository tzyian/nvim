return {
	"mbbill/undotree",
	lazy = true,
	-- event = "VeryLazy",
	cmd = "UndotreeToggle",
	opts = {},
	keys = {
		{ "<leader>u", "<cmd>UndotreeToggle<CR>", silent = true, desc = "Open undotree" },
	},
}
