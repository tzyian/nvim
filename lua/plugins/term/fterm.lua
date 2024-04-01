return {
	"numToStr/FTerm.nvim",
	event = "VeryLazy",
	config = function()
		vim.keymap.set("n", "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>')
		vim.keymap.set("t", "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

		local fterm = require("FTerm")

		local lazygit = fterm:new({
			ft = "fterm_lazygit", -- You can also override the default filetype, if you want
			cmd = "lazygit",
			dimensions = {
				height = 0.9,
				width = 0.9,
			},
		})

		-- Use this to toggle lazygit in a floating terminal
		vim.keymap.set("n", "<A-g>", function()
			lazygit:toggle()
		end)
	end,
}
