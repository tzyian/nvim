return {
	"nvim-lualine/lualine.nvim",
	-- event = "VeryLazy",
	priority = 5000,
	config = function()
		local function diff_source()
			local gitsigns = vim.b.gitsigns_status_dict
			if gitsigns then
				return {
					added = gitsigns.added,
					modified = gitsigns.changed,
					removed = gitsigns.removed,
				}
			end
		end

		require("lualine").setup({
			sections = {
				lualine_b = { { "b:gitsigns_head", icon = "" }, { "diff", source = diff_source }, "diagnostics" },
			},
			options = {
				theme = "catppuccin",
			},
		})
	end,
}
