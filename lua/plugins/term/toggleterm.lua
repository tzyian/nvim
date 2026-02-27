return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		lazy = true,
		cmd = "ToggleTerm",
		opts = {
			float_opts = {
				border = "curved",
				width = math.floor(0.8 * vim.o.columns),
				height = math.floor(0.75 * vim.o.lines),
			},
			highlights = {
				FloatBorder = {
					guifg = "#89B4FA",
				}
			}
		},
		keys = {
			-- Default floating
			{ "<M-i>",      "<cmd>9ToggleTerm dir=git_dir direction=float<CR>",      desc = "Toggle Terminal" },
			{ "<M-i>",      "<C-\\><C-n><cmd>9ToggleTerm<CR>",                       mode = "t",                    desc = "Toggle Terminal" },

			-- Floating terminals
			{ "<M-1>",      "<cmd>lua Term1_toggle()<CR>",                           desc = "Toggle Terminal 1" },
			{ "<M-1>",      "<C-\\><C-n><cmd>lua Term1_toggle()<CR>",                mode = "t",                    desc = "Toggle Terminal 1" },

			{ "<M-2>",      "<cmd>lua Term2_toggle()<CR>",                           desc = "Toggle Terminal 2" },
			{ "<M-2>",      "<C-\\><C-n><cmd>lua Term2_toggle()<CR>",                mode = "t",                    desc = "Toggle Terminal 2" },

			{ "<M-3>",      "<cmd>lua Term3_toggle()<CR>",                           desc = "Toggle Terminal 3" },
			{ "<M-3>",      "<C-\\><C-n><cmd>lua Term3_toggle()<CR>",                mode = "t",                    desc = "Toggle Terminal 3" },

			-- Lazygit
			{ "<M-g>",      "<cmd>lua Lazygit_toggle()<CR>",                         desc = "Open lazygit" },
			{ "<M-g>",      "<C-\\><C-n><cmd>lua Lazygit_toggle()<CR>",              mode = "t",                    desc = "Open lazygit" },

			-- Vertical / horizontal splits
			{ "<leader>t1", "<cmd>5ToggleTerm dir=git_dir direction=vertical<CR>",   desc = "Vertical terminal 1" },
			{ "<leader>t2", "<cmd>6ToggleTerm dir=git_dir direction=vertical<CR>",   desc = "Vertical terminal 2" },
			{ "<leader>t3", "<cmd>7ToggleTerm dir=git_dir direction=horizontal<CR>", desc = "Horizontal terminal 3" },
			{ "<leader>t4", "<cmd>8ToggleTerm dir=git_dir direction=horizontal<CR>", desc = "Horizontal terminal 4" },
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
			local Terminal = require("toggleterm.terminal").Terminal

			vim.api.nvim_set_hl(0, "ToggleTermBorderBlue", { fg = "#89B4FA" })
			vim.api.nvim_set_hl(0, "ToggleTermBorderGreen", { fg = "#40D472" })
			vim.api.nvim_set_hl(0, "ToggleTermBorderOrange", { fg = "#FF9640" })
			vim.api.nvim_set_hl(0, "ToggleTermBorderPink", { fg = "#FF5FAF" })
			vim.api.nvim_set_hl(0, "ToggleTermBorderRed", { fg = "#ED3D4A" })

			local function make_float_term(count, hl_group)
				return Terminal:new({
					count = count,
					dir = "git_dir",
					direction = "float",
					float_opts = {
						border = "curved",
						width = math.floor(0.8 * vim.o.columns),
						height = math.floor(0.75 * vim.o.lines),
					},
					on_open = function(term)
						vim.api.nvim_win_set_option(
							term.window,
							"winhighlight",
							"FloatBorder:" .. hl_group
						)
					end,
				})
			end

			local term1 = make_float_term(1, "ToggleTermBorderGreen")
			local term2 = make_float_term(2, "ToggleTermBorderOrange")
			local term3 = make_float_term(3, "ToggleTermBorderPink")

			function Term1_toggle() term1:toggle() end

			function Term2_toggle() term2:toggle() end

			function Term3_toggle() term3:toggle() end

			-- Lazygit
			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = "git_dir",
				direction = "float",
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(
						term.bufnr, "n", "q", "<cmd>close<CR>",
						{ noremap = true, silent = true }
					)
					vim.api.nvim_win_set_option(
						term.window,
						"winhighlight",
						"FloatBorder:" .. "ToggleTermBorderRed"
					)
				end,
				on_close = function()
					vim.cmd("startinsert!")
				end,
			})

			function Lazygit_toggle() lazygit:toggle() end
		end,
	},
}
