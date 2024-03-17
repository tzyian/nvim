return {
	"NMAC427/guess-indent.nvim",
	event = "VeryLazy",
	config = function()
		require("guess-indent").setup({
			enable = true,
		})
	end,
}
