return {
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",
	config = function()
		require("lspsaga").setup({
			symbol_in_winbar = {
				enabled = false,
				show_file = false,
			},
			implement = {
				enable = false,
			},
			-- breadcrumb = {
			-- 	enable = false,
			-- },
			lightbulb = { enable = false },
			outline = {
				enable = false,
				-- keys = {
				-- 	toggle_or_jump = "<CR>",
				-- },
			},
			rename = {
				keys = {
					quit = "<esc>",
				},
			},
		})

		local map = function(keymap, cmd, desc)
			vim.keymap.set("n", "<leader>" .. keymap, "<cmd>Lspsaga " .. cmd .. "<CR>", { silent = true, desc = desc })
		end

		map("li", "incoming_calls", "Peek Incoming Calls")
		map("lo", "outgoing_calls", "Peek Outgoing Calls")
		map("la", "code_action", "Code action")
		map("ld", "peek_definition", "Peek Definition")
		map("lt", "peek_type_definition", "Peek Type Definition")
		map("lf", "finder ref+def+imp", "Finder")
		map("ln", "diagnostic_jump_next", "Next diagnostic")
		map("lb", "diagnostic_jump_prev", "Prev diagnostic")
		map("lh", "hover", "Hover")
		map("lO", "outline", "outline")
		map("lr", "rename", "Rename")

		vim.keymap.set({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle")
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
}
