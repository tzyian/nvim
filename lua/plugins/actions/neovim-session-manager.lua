return { -- Lua
	-- NOTE: remove
	-- {
	-- 	"folke/persistence.nvim",
	-- 	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	-- 	-- stylua: ignore
	-- 	opts = {
	-- 		-- add any custom options here
	-- 		-- restore the session for the current directory
	-- 		vim.keymap.set("n", "<leader>ss", [[<cmd>lua require("persistence").load()<cr>]], { desc = "Restore session" }),
	--
	-- 		-- restore the last session
	-- 		vim.keymap.set("n", "<leader>sl", [[<cmd>lua require("persistence").load({ last = true })<cr>]],
	-- 			{ desc = "Restore last session" }),
	--
	-- 		-- stop Persistence => session won't be saved on exit
	-- 		vim.keymap.set("n", "<leader>sd", [[<cmd>lua require("persistence").stop()<cr>]], { desc = "Stop session saving" }
	-- 		),
	-- 	},
	-- },
	{
		"Shatur/neovim-session-manager",
		event = "VeryLazy",
		config = function()
			local config = require("session_manager.config")
			require("session_manager").setup({
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
