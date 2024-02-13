return {
	"mrjones2014/smart-splits.nvim",
	config = function()
		local builtin = require("smart-splits")
		-- resizing splits
		vim.keymap.set("n", "<C-Left>", builtin.resize_left, { silent = true })
		vim.keymap.set("n", "<C-Down>", builtin.resize_down, { silent = true })
		vim.keymap.set("n", "<C-Up>", builtin.resize_up, { silent = true })
		vim.keymap.set("n", "<C-Right>", builtin.resize_right, { silent = true })
		-- moving between splits
		vim.keymap.set("n", "<C-h>", builtin.move_cursor_left)
		vim.keymap.set("n", "<C-j>", builtin.move_cursor_down)
		vim.keymap.set("n", "<C-k>", builtin.move_cursor_up)
		vim.keymap.set("n", "<C-l>", builtin.move_cursor_right)
	end,
}
