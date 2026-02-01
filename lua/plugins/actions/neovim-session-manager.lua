return { -- Lua
	{
		"Shatur/neovim-session-manager",
		-- event = "VeryLazy",
		config = function()
			local config = require("session_manager.config")
			require("session_manager").setup({
				-- autoload_mode = { config.AutoloadMode.CurrentDir, config.AutoloadMode.LastSession }, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
				autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
			})

			vim.keymap.set("n", "<leader>ss", "<cmd>SessionManager save_current_session<CR>", { desc = "Save session" })
			vim.keymap.set("n", "<leader>se", "<cmd>SessionManager load_session<CR>", { desc = "Load session" })
			vim.keymap.set(
				"n",
				"<leader>sl",
				"<cmd>SessionManager load_last_session<CR>",
				{ desc = "Load last session" }
			)
			vim.keymap.set(
				"n",
				"<leader>sc",
				"<cmd>SessionManager load_current_dir_session<CR>",
				{ desc = "Load cwd session" }
			)
			vim.keymap.set("n", "<leader>sd", "<cmd>SessionManager delete_session<CR>", { desc = "Delete session" })
		end,
	},
}
