return {
	"karb94/neoscroll.nvim",
	event = "VeryLazy",
	config = function()
		local neoscroll = require("neoscroll")
		neoscroll.setup({
			-- All these keys will be mapped to their corresponding default scrolling animation
			-- mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>" },
			hide_cursor = true,        -- Hide cursor while scrolling
			stop_eof = true,           -- Stop at <EOF> when scrolling downwards
			respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
			cursor_scrolls_alone = false, -- The cursor will keep on scrolling even if the window cannot scroll further
			easing = "circular",       -- Default easing function
			pre_hook = nil,            -- Function to run before the scrolling animation starts
			post_hook = nil,           -- Function to run after the scrolling animation ends
			performance_mode = false,  -- Disable "Performance Mode" on all buffers.
		})

		local keymap = {
			["<C-u>"] = function()
				neoscroll.ctrl_u({ duration = 50, easing = "circular" })
			end,
			["<C-d>"] = function()
				neoscroll.ctrl_d({ duration = 50, easing = "circular" })
			end,
			-- Use the "circular" easing function
			["<C-b>"] = function()
				neoscroll.ctrl_b({ duration = 75, easing = "circular" })
			end,
			["<C-f>"] = function()
				neoscroll.ctrl_f({ duration = 75, easing = "circular" })
			end,
		}

		local modes = { "n", "v", "x" }
		for key, func in pairs(keymap) do
			vim.keymap.set(modes, key, func)
		end
	end,
}
