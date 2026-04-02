return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
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

		local function wordcount()
			local label = "word"
			local word_count = 0

			if vim.fn.mode():find("[vV]") then
				word_count = vim.fn.wordcount().visual_words
			else
				word_count = vim.fn.wordcount().words
			end

			if word_count ~= 1 then
				label = label .. "s"
			end

			return word_count .. " " .. label
		end


		local filetypes = { "typst", "markdown", "text", "tex" }

		require("lualine").setup({
			sections = {
				lualine_b = { { "b:gitsigns_head", icon = "" }, { "diff", source = diff_source }, "diagnostics" },
				lualine_x = { {
					wordcount,
					cond = function()
						return vim.tbl_contains(filetypes, vim.bo.filetype)
					end
				}, "encoding", "fileformat", "filetype" },
			},
			options = {
				theme = "catppuccin-nvim",
			},
			extensions = { "nvim-tree", }
		})
	end,
}
