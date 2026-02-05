return {
	"goolord/alpha-nvim",
	-- event = "BufWinEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	cmd = { "Alpha" },
	event = "VimEnter",
	priority = 1000,

	config = function()
		if vim.fn.argc() > 0 then
			return
		end

		local alpha = require("alpha")
		local dashboard = require("alpha.themes.startify")

		dashboard.section.header.val = {
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                     ]],
			[[       ████ ██████           █████      ██                     ]],
			[[      ███████████             █████                             ]],
			[[      █████████ ███████████████████ ███   ███████████   ]],
			[[     █████████  ███    █████████████ █████ ██████████████   ]],
			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
		}

		alpha.setup(dashboard.opts)

		vim.keymap.set("n", "<leader>ms", ":Alpha<CR>", { noremap = true, silent = true, desc = "Open Startify" })
	end,
}
