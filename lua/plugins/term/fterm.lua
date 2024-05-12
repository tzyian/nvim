return {
	"numToStr/FTerm.nvim",
	lazy = true,
	keys = {
		{
			"<A-i>",
			'<cmd>lua require("FTerm").toggle()<CR>',
			desc = "Toggle FTerm",
		},
		{
			"<A-g>",
			'<cmd>lua require("FTerm"):new({ft="fterm_lazygit", cmd = "lazygit", dimensions = {height = 0.9, width = 0.9}}):toggle()<CR>',
			desc = "Toggle lazygit",
		},
	},
	config = function()
		vim.keymap.set("t", "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

		-- local fterm = require("FTerm")
		--
		-- local lazygit = fterm:new({
		-- 	ft = "fterm_lazygit", -- You can also override the default filetype, if you want
		-- 	cmd = "lazygit",
		-- 	dimensions = {
		-- 		height = 0.9,
		-- 		width = 0.9,
		-- 	},
		-- })
		--
		-- -- Use this to toggle lazygit in a floating terminal
		-- vim.keymap.set("n", "<A-g>", function()
		-- 	lazygit:toggle()
		-- end)
	end,
}
