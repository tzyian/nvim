return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	-- lazy = true,
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
		lang = "t",
		-- i think ambiguous config makes it select every time
	},
	keys = {
		{ "<leader>zz", "<cmd>Leet<CR>",         desc = "Leet" },
		{ "<leader>zt", "<cmd>Leet test<CR>",    desc = "Leet test" },
		{ "<leader>zS", "<cmd>Leet submit<CR>",  desc = "Leet submit" },
		{ "<leader>zl", "<cmd>Leet lang<CR>",    desc = "Leet lang" },
		{ "<leader>zd", "<cmd>Leet desc<CR>",    desc = "Leet desc" },
		{ "<leader>zc", "<cmd>Leet console<CR>", desc = "Leet console" },
		{ "<leader>zy", "<cmd>Leet yank<CR>",    desc = "Leet yank" },
		{ "<leader>zr", "<cmd>Leet restore<CR>", desc = "Leet restore" },
		{ "<leader>zr", "<cmd>Leet reset<CR>",   desc = "Leet reset" },
		{ "<leader>zo", "<cmd>Leet open<CR>",    desc = "Leet open" },
	},
}
