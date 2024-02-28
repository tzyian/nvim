return -- Lua
{
	"folke/persistence.nvim",
	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	-- stylua: ignore
	opts = {
		-- add any custom options here
		-- restore the session for the current directory
		vim.keymap.set("n", "<leader>ss", [[<cmd>lua require("persistence").load()<cr>]], { desc = "Restore session" }),

		-- restore the last session
		vim.keymap.set("n", "<leader>sl", [[<cmd>lua require("persistence").load({ last = true })<cr>]],
			{ desc = "Restore last session" }),

		-- stop Persistence => session won't be saved on exit
		vim.keymap.set("n", "<leader>sd", [[<cmd>lua require("persistence").stop()<cr>]], { desc = "Stop session saving" }
		),
	},
}
