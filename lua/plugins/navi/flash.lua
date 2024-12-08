return {
	"folke/flash.nvim",
	event = "VeryLazy",
	-- @type Flash.Config
	opts = {
		modes = {
			search = {
				enabled = true,
				incremental = false,
			},
			-- char = {
			-- 	jump_labels = true,
			-- },
		},
	},
	-- stylua: ignore
	keys = {
		{ "<Leader><Tab>", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
		-- NOTE: <Tab> is equivalent to <C-i> 
		--
		-- { "<Tab>",         mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
		{ "S",             mode = { "n", "o" },      function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
		-- Flash Treesitter usage: yS + select textobject
		{ "r",             mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
		-- Remote Flash usage: yr + <cursor moves to location> iw (in-word)
		{ "R",             mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		-- Treesitter Search usage: yR + <type text> + <select textobject on screen>
		{ "<c-s>",         mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
	},
}
