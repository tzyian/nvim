return {
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			-- add options here
			-- or leave it empty to use the default settings
			default = {
				prompt_for_file_name = false,
			},
		},
		keys = {
			-- suggested keymap
			{ "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
		},
	},
}
