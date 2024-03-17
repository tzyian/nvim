return {
	"mbbill/undotree",
	lazy = true,
	-- event = "VeryLazy",
	cmd = "UndotreeToggle",
	opt = {
		vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { silent = true, desc = "Toggle undotree" }),
	}
}
