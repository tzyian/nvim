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
				"<cmd>Copilot disable<CR>",
				desc = "Copilot disable",
			},
			{
				"<leader>cP",
				"<cmd>Copilot enable<CR>",
				desc = "Copilot enable",
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
		lazy = true,
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			-- See Configuration section for rest
			model = "claude-3.5-sonnet",
			-- auto_follow_cursor = false,
			answer_header = "## Copilot \n `<C-s>` to Accept, `<C-d>` to Reset, `gd` to show Diffs, `g?` for Help ",

			-- Note that Copilot may not always generate differences if the prompts are not used

			mappings = {
				submit_prompt = {
					normal = "<CR>",
					insert = "<C-CR>",
				},
				accept_diff = {
					normal = "<C-s>",
					insert = "<C-s>",
				},
				reset = {
					normal = "<C-d>",
					insert = "<C-d>",
				},
				yank_diff = {
					register = "*",
				},
				show_help = {
					normal = "g?",
				},
			},
		},
		-- config = function(_, opts)
		-- 	require("CopilotChat").setup(opts)
		-- end,

		keys = {
			{
				"<leader>aa",
				"<cmd>CopilotChatToggle<cr>",
				mode = { "n", "v" },
				desc = "CopilotChat - Toggle",
			},
			{
				"<leader>at",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
					end
				end,
				mode = { "n", "v" },
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
