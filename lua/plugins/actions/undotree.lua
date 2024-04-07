return {
	"mbbill/undotree",
	lazy = true,
	-- event = "VeryLazy",
	cmd = "UndotreeToggle",
	opt = {},
	keys = {
		{ "<leader>u", ":UndotreeToggle<CR>", silent = true, desc = "Toggle undotree" },
	},
}
