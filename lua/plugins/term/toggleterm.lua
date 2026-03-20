return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		lazy = true,
		cmd = "ToggleTerm",
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
		},
		keys = {
			-- Default floating
			{ "<M-i>",      "<cmd>lua Term9_toggle()<CR>",                           desc = "Toggle Terminal" },
			{ "<M-i>",      "<C-\\><C-n><cmd>lua Term9_toggle()<CR>",                mode = "t",                    desc = "Toggle Terminal" },

			-- Floating terminals
			{ "<M-1>",      "<cmd>lua Term6_toggle()<CR>",                           desc = "Toggle Terminal 1" },
			{ "<M-1>",      "<C-\\><C-n><cmd>lua Term6_toggle()<CR>",                mode = "t",                    desc = "Toggle Terminal 6" },

			{ "<M-2>",      "<cmd>lua Term7_toggle()<CR>",                           desc = "Toggle Terminal 2" },
			{ "<M-2>",      "<C-\\><C-n><cmd>lua Term7_toggle()<CR>",                mode = "t",                    desc = "Toggle Terminal 7" },

			{ "<M-3>",      "<cmd>lua Term8_toggle()<CR>",                           desc = "Toggle Terminal 3" },
			{ "<M-3>",      "<C-\\><C-n><cmd>lua Term8_toggle()<CR>",                mode = "t",                    desc = "Toggle Terminal 8" },

			-- Lazygit
			{ "<M-g>",      "<cmd>lua Lazygit_toggle()<CR>",                         desc = "Open lazygit" },
			{ "<M-g>",      "<C-\\><C-n><cmd>lua Lazygit_toggle()<CR>",              mode = "t",                    desc = "Open lazygit" },

			-- Vertical / horizontal splits
			{ "<leader>t1", "<cmd>1ToggleTerm dir=git_dir direction=vertical<CR>",   desc = "Vertical terminal 1" },
			{ "<leader>tt", "<cmd>1ToggleTerm dir=git_dir direction=vertical<CR>",   desc = "Vertical terminal 1" },
			{ "<leader>t2", "<cmd>2ToggleTerm dir=git_dir direction=vertical<CR>",   desc = "Vertical terminal 2" },
			{ "<leader>t3", "<cmd>3ToggleTerm dir=git_dir direction=horizontal<CR>", desc = "Horizontal terminal 3" },
			{ "<leader>tT", "<cmd>3ToggleTerm dir=git_dir direction=horizontal<CR>", desc = "Horizontal terminal 3" },
			{ "<leader>t4", "<cmd>4ToggleTerm dir=git_dir direction=horizontal<CR>", desc = "Horizontal terminal 4" },
		},

		config = function(_, opts)
			require("toggleterm").setup(opts)
			local Terminal = require("toggleterm.terminal").Terminal

			vim.api.nvim_set_hl(0, "ToggleTermBorderBlue", { fg = "#89B4FA" })
			vim.api.nvim_set_hl(0, "ToggleTermBorderGreen", { fg = "#40D472" })
			vim.api.nvim_set_hl(0, "ToggleTermBorderOrange", { fg = "#FF9640" })
			vim.api.nvim_set_hl(0, "ToggleTermBorderPink", { fg = "#FF5FAF" })
			vim.api.nvim_set_hl(0, "ToggleTermBorderRed", { fg = "#ED3D4A" })

			local function get_dir()
				-- Terminal:new "git_dir" chokes on WSL /mnt/c/ non-git dirs with hyphens
				-- but doesn't choke when passed as :lua dir=git_dir???
				local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
				if vim.v.shell_error == 0 and git_root and git_root ~= "" then
					return git_root
				end
				return vim.fn.getcwd()
			end

			local function make_float_term(count, hl_group)
				return Terminal:new({
					count = count,
					dir = get_dir(),
					direction = "float",
					float_opts = {
						border = "curved",
						width = math.floor(0.8 * vim.o.columns),
						height = math.floor(0.75 * vim.o.lines),
					},
					on_open = function(term)
						vim.api.nvim_set_option_value(
							"winhl",
							"FloatBorder:" .. hl_group,
							{ win = term.window, scope = "local" }
						)
						vim.schedule(function()
							if vim.api.nvim_buf_is_valid(term.bufnr) then
								vim.cmd("startinsert!")
							end
						end)
					end,
				})
			end

			local term9 = make_float_term(9, "ToggleTermBorderBlue")
			local term6 = make_float_term(6, "ToggleTermBorderGreen")
			local term7 = make_float_term(7, "ToggleTermBorderOrange")
			local term8 = make_float_term(8, "ToggleTermBorderPink")

			function Term9_toggle() term9:toggle() end

			function Term6_toggle() term6:toggle() end

			function Term7_toggle() term7:toggle() end

			function Term8_toggle() term8:toggle() end

			-- Lazygit
			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = get_dir(),
				direction = "float",
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(
						term.bufnr, "n", "q", "<cmd>close<CR>",
						{ noremap = true, silent = true }
					)
					vim.api.nvim_set_option_value(
						"winhighlight",
						"FloatBorder:" .. "ToggleTermBorderRed",
						{ win = term.window, scope = "local" }
					)
				end,
			})

			function Lazygit_toggle() lazygit:toggle() end
		end,
	},
}
