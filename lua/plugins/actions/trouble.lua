return {
	"folke/trouble.nvim",
	lazy = true,
	opts = {}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {

		{
			"<leader>qq",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>qQ",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>o",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},

		{
			"<leader>qs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>ql",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>qL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>qf",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
		{
			"<leader>qt",
			"<cmd>Trouble todo<cr>",
			desc = "Todo Comments (Trouble)",
		},
		{
			"<leader>qa",
			function()
				vim.fn.setqflist({
					{ filename = vim.fn.expand("%:p"), lnum = vim.fn.line("."), text = vim.fn.getline(".") }
				}, "a")
			end,
			desc = "Add line to quickfix"
		},

		{
			"<leader>qq",
			function()
				if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
					vim.cmd.cclose()
				else
					vim.cmd.copen()
				end
			end,
			desc = "Toggle quickfix"
		},

		{
			"<leader>qc",
			function() vim.fn.setqflist({}, "r") end,
			desc = "Clear quickfix"
		}
	},

}
