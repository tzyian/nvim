return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	config = function()
		require("which-key").add({
			{ "<leader>T",  group = "Split Terminal" },
			{ "<leader>a",  group = "Copilot Chat",   mode = { "n", "v" } },
			{ "<leader>b",  group = "Buffer" },
			{ "<leader>c",  group = "Code" },
			{ "<leader>ct", group = "Toggle format" },
			{ "<leader>d",  group = "Debug" },
			{ "<leader>f",  group = "Find" },
			{ "<leader>g",  group = "Go" },
			{ "<leader>h",  group = "Git Hunk",       mode = { "n", "v" } },
			{ "<leader>ht", group = "Toggle" },
			{ "<leader>l",  group = "VimTex" },
			{ "<leader>m",  group = "Misc Config" },
			{ "<leader>p",  group = "Preview" },
			{ "<leader>q",  group = "Diagnostics" },
			{ "<leader>r",  group = "SnipRun" },
			{ "<leader>s",  group = "Session" },
			{ "<leader>t",  group = "Vsplit Terminal" },
			{ "<leader>z",  group = "Leet" },
			{ "<leader>fl", group = "Lsp" },
			{ "<leader>fh", group = "Git" },
		})
	end,
}
