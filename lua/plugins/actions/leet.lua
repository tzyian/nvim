return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim", -- required by telescope
		"MunifTanjim/nui.nvim",

		-- optional
		"nvim-treesitter/nvim-treesitter",
		-- "rcarriga/nvim-notify",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		-- configuration goes here
		lang = "python3",
	},
	keys = {
		{ "<leader>zz", "<cmd>Leet<CR>",               desc = "Leet" },
		{ "<leader>zd", "<cmd>Leet<CR>Leet daily<CR>", desc = "Leet daily" },
		{ "<leader>zt", "<cmd>Leet test<CR>",          desc = "Leet test" },
		{ "<leader>zS", "<cmd>Leet submit<CR>",        desc = "Leet submit" },
		{ "<leader>zl", "<cmd>Leet lang<CR>",          desc = "Leet lang" },
		{ "<leader>zD", "<cmd>Leet desc<CR>",          desc = "Leet desc" },
	},
}
