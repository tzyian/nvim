return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true,
				},
			})
		end,
		keys = {
			{
				"<M-c>",
				mode = { "n", "i" },
				"<cmd>Copilot panel<CR>",
				desc = "Open Copilot panel",
			},
			{
				"<leader>cp",
				"<cmd>Copilot toggle<CR>",
				desc = "Copilot toggle",
			},
			{
				"<leader>cP",
				"<cmd>Copilot status<CR>",
				desc = "Copilot status",
			},
		},
	},
	{
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		lazy = true,
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = true, -- Enable debugging
			-- See Configuration section for rest
			config = function()
				require("CopilotChat.integrations.cmp").setup()
			end,
		},
		keys = {
			{
				"<leader>at",
				"<cmd>CopilotChatToggle<cr>",
				mode = { "n", "v" },
				desc = "CopilotChat - Toggle",
			},
			{
				"<leader>aa",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
					end
				end,
				desc = "CopilotChat - Quick chat",
			},
			{
				"<leader>ap",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				mode = { "n", "v" },
				desc = "CopilotChat - Prompt actions",
			},
		},
	},
}
