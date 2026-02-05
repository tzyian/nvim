return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		if vim.g.barbecue_enabled == nil then
			vim.g.barbecue_enabled = true
		end
		if vim.g.context_enabled == nil then
			vim.g.context_enabled = true
		end
	end,
	opts = {
		spec = {
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

			{
				"<leader>cc",
				desc = "Toggle Context",
				icon = function()
					if vim.g.context_enabled then
						return { icon = " ", color = "green" }
					else
						return { icon = " ", color = "yellow" }
					end
				end,
			},
			{
				"<leader>cb",
				function()
					vim.g.barbecue_enabled = not vim.g.barbecue_enabled
					require("barbecue.ui").toggle()
				end,
				desc = "Toggle breadcrumbs",
				icon = function()
					if vim.g.barbecue_enabled then
						return { icon = " ", color = "green" }
					else
						return { icon = " ", color = "yellow" }
					end
				end,
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
		},
	},
}
