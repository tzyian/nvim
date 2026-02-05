return { -- Lua
	{
		"Shatur/neovim-session-manager",
		cmd = {
			"SessionManager",
			"SessionManager load_session",
			"SessionManager load_last_session",
			"SessionManager load_current_dir_session",
			"SessionManager save_current_session",
			"SessionManager delete_session",
		},
		keys = {
			{ "<leader>ss", "<cmd>SessionManager save_current_session<CR>", desc = "Save session" },
			{ "<leader>se", "<cmd>SessionManager load_session<CR>", desc = "Load session" },
			{ "<leader>sl", "<cmd>SessionManager load_last_session<CR>", desc = "Load last session" },
			{ "<leader>sc", "<cmd>SessionManager load_current_dir_session<CR>", desc = "Load cwd session" },
			{ "<leader>sd", "<cmd>SessionManager delete_session<CR>", desc = "Delete session" },
		},
		config = function()
			local config = require("session_manager.config")
			require("session_manager").setup({
				-- autoload_mode = { config.AutoloadMode.CurrentDir, config.AutoloadMode.LastSession }, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
				autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
			})
		end,
	},
}
