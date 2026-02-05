return {
	"folke/which-key.nvim",
	-- event = "VeryLazy",
	opts = {},
	config = function()
		require("which-key").add({
			{ "<leader>a",  group = "Copilot Chat", mode = { "n", "v" } },
			{ "<leader>b",  group = "Buffer" },
			{ "<leader>c",  group = "Code",         mode = { "n", "v" } },
			{ "<leader>ct", group = "Toggle format" },
			{ "<leader>d",  group = "Debug" },
			{ "<leader>f",  group = "Find" },
			{ "<leader>g",  group = "GoTo" },
			{ "<leader>h",  group = "Git Hunk",     mode = { "n", "v" } },
			{ "<leader>ht", group = "Toggle" },
			{ "<leader>l",  group = "FileType" },
			{ "<leader>m",  group = "Misc Config" },
				{ "<leader>n",  "<cmd>NvimTreeToggle<CR>", desc = "Open file tree" },
			{ "<leader>p",  group = "Preview" },
			{ "<leader>q",  group = "Diagnostics" },
			{ "<leader>r",  group = "SnipRun",      mode = { "n", "v" } },
			{ "<leader>s",  group = "Session" },
			{ "<leader>S",  group = "sshfs" },
			{ "<leader>t",  group = "Terminal" },
			{ "<leader>z",  group = "Leet" },
			{ "<leader>fl", group = "Lsp" },
			{ "<leader>fh", group = "Git" },

			-- I'm not sure how to shift this out. I think cos my plugins are lazy but this is not
			{
				"<leader>cb",
				"<cmd>lua require('barbecue.ui').toggle()<CR>",
				desc = "Toggle breadcrumbs",
				icon = { icon = " ", color = "green" },
			},
			{
				"<leader>cg",
				"<cmd>ToggleBufferFormat<CR>",
				desc = "Toggle format on save (buffer)",
				icon = function()
					if vim.b.disable_autoformat then
						return { icon = " ", color = "yellow" }
					else
						return { icon = " ", color = "green" }
					end
				end,
			},
			{
				"<leader>cG",
				"<cmd>ToggleGlobalFormat<CR>",
				desc = "Toggle format on save (global)",
				icon = function()
					if vim.g.disable_autoformat then
						return { icon = " ", color = "yellow" }
					else
						return { icon = " ", color = "green" }
					end
				end,
			},
		})
	end,
}
