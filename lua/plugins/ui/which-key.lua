return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = function()
		-- document existing key chains
		require("which-key").register({
			["<leader>f"] = { name = "[F]ind", _ = "which_key_ignore" },
			["<leader>g"] = { name = "[G]o", _ = "which_key_ignore" },
			["<leader>b"] = { name = "[B]uffer", _ = "which_key_ignore" },
			["<leader>d"] = { name = "[D]ebug", _ = "which_key_ignore" },
			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
			["<leader>t"] = { name = "Vsplit [T]erminal", _ = "which_key_ignore" },
			["<leader>T"] = { name = "Split [T]erminal", _ = "which_key_ignore" },
			["<leader>q"] = { name = "Diagnostics", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[S]ession", _ = "which_key_ignore" },
			["<leader>r"] = { name = "Snip[R]un", _ = "which_key_ignore" },
			["<leader>m"] = { name = "[M]isc Config", _ = "which_key_ignore" },
			["<leader>p"] = { name = "Preview", _ = "which_key_ignore" },
			["<leader>a"] = { name = "Copilot Chat", _ = "which_key_ignore" },

			-- Prefixes
			["<leader>ct"] = { name = "Toggle format", _ = "which_key_ignore" },
			["<leader>ht"] = { name = "Toggle", _ = "which_key_ignore" },
			-- ["<leader>l"] = { name = "Lspsaga", _ = "which_key_ignore" },
		})

		-- register which-key VISUAL mode
		-- required for visual <leader>hs (hunk stage) to work
		require("which-key").register({
			["<leader>"] = { name = "VISUAL <leader>" },
			["<leader>h"] = { "Git [H]unk" },
		}, { mode = "v" })
	end,
}
