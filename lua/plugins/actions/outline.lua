return {
	"hedyhli/outline.nvim",
	lazy = true,
	cmd = { "Outline", "OutlineOpen" },
	keys = { -- Example mapping to toggle outline
		{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
	},
	opts = {
		-- Your setup opts here
		keymaps = {
			show_help = "g?",
			peek_location = "<Tab>",
			fold_toggle = "t",
		},
		symbols = {
			filter = {
				python = { "Function", "Class" },
			},
		},
	},
}
