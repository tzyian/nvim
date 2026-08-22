return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			-- Creates a beautiful debugger UI
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",

			-- Installs the debug adapters for you
			"mason-org/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",

			-- Add your own debuggers here
			-- { "leoluz/nvim-dap-go",           event = "VeryLazy", ft = "go" },
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
			{ "<Leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Debug: Toggle Breakpoint (F9)" },
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
			vim.fn.sign_define("DapBreakpoint", {
				text = "●", -- a large dot
				texthl = "DapBreakpointSign",
			})

			local dap = require("dap")
			local dapui = require("dapui")

			local function cpp_prog()
				local filename = vim.fn.expand("%:t")

				if filename:match("^%d+%.[%w%-]+%.cpp$") then
					vim.cmd("write")

					local executable = vim.fn.tempname()
					local compiler = "g++ -std=c++23 -O0 -g -include "
							.. vim.fn.shellescape(vim.env.HOME .. "/leetcode/debug.hpp")
							.. " " .. vim.fn.shellescape(vim.fn.expand("%:p"))
							.. " -o " .. vim.fn.shellescape(executable)
					local output = vim.fn.system(compiler)

					if vim.v.shell_error ~= 0 then
						vim.notify("C++ debug build failed:\n" .. output, vim.log.levels.ERROR)
						return nil
					end

					return executable
				end

				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end

			require("mason-nvim-dap").setup({
				-- Makes a best effort to setup the various debuggers with
				-- reasonable debug configurations
				automatic_setup = true,
				automatic_installation = false,

				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {},

				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
					-- "delve",
					"debugpy",
				},
			})

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = cpp_prog,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp


			-- Dap UI setup
			-- For more information, see |:help nvim-dap-ui|
			dapui.setup({
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

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			-- require("dap-go").setup()
			require("dap-python").setup()
		end,
	},
}
