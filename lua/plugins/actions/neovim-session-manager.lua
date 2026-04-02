return { -- Lua
	{
		"Shatur/neovim-session-manager",
		event = "VimEnter",
		cmd = {
			"SessionManager",
		},
		keys = {
			{ "<leader>ss", "<cmd>SessionManager save_current_session<CR>",     desc = "Save session" },
			{ "<leader>se", "<cmd>SessionManager load_session<CR>",             desc = "Load session" },
			{ "<leader>sl", "<cmd>SessionManager load_last_session<CR>",        desc = "Load last session" },
			{ "<leader>sc", "<cmd>SessionManager load_current_dir_session<CR>", desc = "Load cwd session" },
			{ "<leader>sd", "<cmd>SessionManager delete_session<CR>",           desc = "Delete session" },
		},
		config = function()
			local config = require("session_manager.config")
			require("session_manager").setup({
				autoload_mode = { config.AutoloadMode.Disabled, }
			})
		end,
	},
}
