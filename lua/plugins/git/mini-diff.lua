local function set_hunk_list(scope, title)
	local diff = require("mini.diff")
	vim.fn.setqflist({}, " ", { title = title, items = diff.export("qf", { scope = scope }) })
	vim.cmd.copen()
end

return {
	"nvim-mini/mini.diff",
	version = false,
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		view = {
			style = "number",
			-- signs = { add = "+", change = "~", delete = "_" },
		},
		mappings = {
			-- apply = "<leader>hs",
			-- reset = "<leader>hr",
			-- textobject = "ih",
			-- goto_prev = "[h",
			-- goto_next = "]h",
			apply = "",
			reset = "",
			textobject = "",
			goto_prev = "",
			goto_next = "",
		},
	},
	keys = {
		{ "<leader>htl", function() require("mini.diff").toggle_overlay() end, desc = "Toggle Git Diff Overlay" },
		-- { "<leader>hS", function() require("mini.diff").do_hunks(0, "apply") end,           desc = "Stage git buffer" },
		-- { "<leader>hR", function() require("mini.diff").do_hunks(0, "reset") end,           desc = "Reset git buffer" },
		-- { "<leader>hq", function() set_hunk_list("current", "Git hunks (buffer)") end,      desc = "Git hunk list (buffer)" },
		-- { "<leader>hQ", function() set_hunk_list("all", "Git hunks (enabled buffers)") end, desc = "Git hunk list (enabled buffers)" },
	},
}
