return {
	{
		"zbirenbaum/copilot.lua",
		dependencies = { "copilotlsp-nvim/copilot-lsp", },
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			server_opts_overrides = {
				settings = {
					telemetry = {
						telemetryLevel = "off",
					},
				},
			},
			suggestion = {
				enabled = true,
			},
			nes = {
				enabled = false,
				keymap = {
					accept_and_goto = "<M-c>",
					accept = false,
					dismiss = "<Esc>",
				},
			},
		},
		keys = {
			{
				"<leader>cT",
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
}
