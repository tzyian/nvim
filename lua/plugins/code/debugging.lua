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
			{ "leoluz/nvim-dap-go",           event = "VeryLazy", ft = "go" },
			{ "mfussenegger/nvim-dap-python", event = "VeryLazy", ft = "python" },
		},
		keys = function()
			local dap = require("dap")
			local dapui = require("dapui")

			return {
				{ "<F5>",       function() dap.continue() end,          desc = "Debug: Start/Continue (F5)" },
				{ "<Leader>dd", function() dap.continue() end,          desc = "Debug: Start/Continue (F5)" },
				{ "<F1>",       function() dap.step_into() end,         desc = "Debug: Step Into (F1)" },
				{ "<Leader>di", function() dap.step_into() end,         desc = "Debug: Step Into (F1)" },
				{ "<F2>",       function() dap.step_over() end,         desc = "Debug: Step Over (F2)" },
				{ "<Leader>do", function() dap.step_over() end,         desc = "Debug: Step Over (F2)" },
				{ "<F3>",       function() dap.step_out() end,          desc = "Debug: Step Out (F3)" },
				{ "<Leader>du", function() dap.step_out() end,          desc = "Debug: Step Out (F3)" },
				{ "<F9>",       function() dap.toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint (F9)" },
				{ "<Leader>db", function() dap.toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint (F9)" },
				{ "<Leader>dt", function() dap.toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint (F9)" },
				{ "<Leader>dx", function() dap.terminate() end,         desc = "Debug: Terminate session" },
				{
					"<Leader>dB",
					function()
						dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
					end,
					desc = "Debug: Set Breakpoint",
				},
				{ "<F7>",       function() dapui.toggle() end, desc = "Debug: See last session result (F7)" },
				{ "<Leader>dl", function() dapui.toggle() end, desc = "Debug: See last session result (F7)" },
			}
		end,
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

			require("dap-go").setup()
			require("dap-python").setup()
		end,
	},
}
