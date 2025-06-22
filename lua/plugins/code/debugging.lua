return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			-- Creates a beautiful debugger UI
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",

			-- Installs the debug adapters for you
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",

			-- Add your own debuggers here
			{ "leoluz/nvim-dap-go",           event = "VeryLazy", ft = "go" },
			{ "mfussenegger/nvim-dap-python", event = "VeryLazy", ft = "python" },
		},
		keys = {
			{ "<F5>",       "<cmd>lua require('dap').continue()<CR>",          desc = "Debug: Start/Continue (F5)" },
			{ "<Leader>dd", "<cmd>lua require('dap').continue()<CR>",          desc = "Debug: Start/Continue (F5)" },
			{ "<F1>",       "<cmd>lua require('dap').step_into()<CR>",         desc = "Debug: Step Into (F1)" },
			{ "<Leader>di", "<cmd>lua require('dap').step_into()<CR>",         desc = "Debug: Step Into (F1)" },
			{ "<F2>",       "<cmd>lua require('dap').step_over()<CR>",         desc = "Debug: Step Over (F2)" },
			{ "<Leader>do", "<cmd>lua require('dap').step_over()<CR>",         desc = "Debug: Step Over (F2)" },
			{ "<F3>",       "<cmd>lua require('dap').step_out()<CR>",          desc = "Debug: Step Out (F3)" },
			{ "<Leader>du", "<cmd>lua require('dap').step_out()<CR>",          desc = "Debug: Step Out (F3)" },
			{ "<F9>",       "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Debug: Toggle Breakpoint (F9)" },
			{ "<Leader>dt", "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Debug: Toggle Breakpoint (F9)" },
			{ "<Leader>dx", "<cmd>lua require('dap').terminate()<CR>",         desc = "Debug: Terminate session" },
			{
				"<Leader>dB",
				"<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
				desc = "Debug: Set Breakpoint",
			},
			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			{ "<F7>",       "<cmd>lua require('dapui').toggle()<CR>", desc = "Debug: See last session result (F7)" },
			{ "<Leader>dl", "<cmd>lua require('dapui').toggle()<CR>", desc = "Debug: See last session result (F7)" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("mason-nvim-dap").setup({
				-- Makes a best effort to setup the various debuggers with
				-- reasonable debug configurations
				automatic_setup = true,

				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {},

				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
					"delve",
					"debugpy",
				},
			})

			-- Basic debugging keymaps, feel free to change to your liking!
			-- vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
			-- vim.keymap.set("n", "<leader>dd", dap.continue, { desc = "Debug: Start/Continue (F5)" })
			--
			-- vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
			-- vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into (F1)" })
			--
			-- vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
			-- vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over (F2)" })
			--
			-- vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
			-- vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Debug: Step Out (F3)" })
			--
			-- vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint (F9)" })
			-- vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			-- vim.keymap.set("n", "<leader>dB", function()
			-- 	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			-- end, { desc = "Debug: Set Breakpoint" })

			-- Dap UI setup
			-- For more information, see |:help nvim-dap-ui|
			dapui.setup({
				-- Set icons to characters that are more likely to work in every terminal.
				--    Feel free to remove or use ones that you like more! :)
				--    Don't feel like these are good choices.
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				controls = {
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "b",
						run_last = "▶▶",
						terminate = "⏹",
						disconnect = "⏏",
					},
				},
			})

			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			-- vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })
			-- vim.keymap.set("n", "<leader>dl", dapui.toggle, { desc = "Debug: See last session result." })

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			require("dap-go").setup()
			require("dap-python").setup("~/.pyenv/versions/pynvim/bin/python")
			require("java-debug-adapter").setup()
		end,
	},
}
