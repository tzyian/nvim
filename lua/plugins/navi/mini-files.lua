return {
	"echasnovski/mini.files",
	version = false,
	lazy = true,
	keys = {
		{ "<leader>N", "<cmd>lua require('mini.files').toggle()<CR>", desc = "Toggle mini.files" },
	},
	config = function()
		local MiniFiles = require("mini.files")

		local minifiles_toggle = function(...)
			if not MiniFiles.close() then
				MiniFiles.open(...)
			end
		end

		MiniFiles.setup({
			options = {
				use_as_default_explorer = false,
			},
		})
		vim.keymap.set("n", "<leader>N", minifiles_toggle, { desc = "Toggle mini.files" })
	end,
}
