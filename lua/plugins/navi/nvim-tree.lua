-- 	NOTE: remove
--
-- 	"nvim-neo-tree/neo-tree.nvim",
-- 	branch = "v3.x",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		"nvim-tree/nvim-web-devicons",
-- 		"MunifTanjim/nui.nvim",
-- 	},
-- 	config = function()
-- 		vim.keymap.set("n", "<leader>n", ":Neotree toggle=true <CR>", { silent = true, desc = "Open Neotree" })
-- 		vim.keymap.set(
-- 			"n",
-- 			"<leader>bf",
-- 			":Neotree buffers reveal float<CR>",
-- 			{ silent = true, desc = "Open buffers float" }
-- 		)
-- 	end,
-- }

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "BufWinEnter",
	cmd = "NvimTreeToggle",
	config = function()
		local api = require("nvim-tree.api")

		local function edit_or_open()
			local node = api.tree.get_node_under_cursor()

			if node.nodes ~= nil then
				-- expand or collapse folder
				api.node.open.edit()
			else
				-- open file
				api.node.open.preview()
			end
		end

		local function del_arr_keys(bufnr, key_arr)
			for _, key in ipairs(key_arr) do
				vim.keymap.del("n", key, { buffer = bufnr })
			end
		end

		local function on_attach_change(bufnr)
			local function opts(desc)
				return {
					desc = "nvim-tree: " .. desc,
					buffer = bufnr,
					noremap = true,
					silent = true,
					nowait = true,
				}
			end
			local function nmap(key, cmd, desc)
				vim.keymap.set("n", key, cmd, opts(desc))
			end

			api.config.mappings.default_on_attach(bufnr)

			--[[
			-- Most important keymaps
			-- ----------------------
			-- x: Cut
			-- c: Copy
			-- p: Paste
			-- L: Preview
			--]]

			nmap("<leader>n", "<cmd>NvimTreeToggle<CR>", "Toggle NvimTree")
			nmap(".", api.tree.change_root_to_node, "Change root to node")
			nmap(",", api.node.run.cmd, "Run command")
			nmap("<C-s>", api.node.open.vertical, "Open: Vertical Split")
			nmap("<C-x>", api.node.open.horizontal, "Open: Horizontal Split")
			nmap("l", api.node.open.preview, "Preview")
			nmap("h", api.node.navigate.parent_close, "Parent")
			nmap("?", api.tree.toggle_help, "Help")

			del_arr_keys(bufnr, {
				"<C-v>",
				"<C-e>",
				"<C-]>",
				"J",
				"K",
				"<BS>",
				"<Tab>",
				"<",
				">",
				"-",
				"g?",
				"I",
			})
		end

		require("nvim-tree").setup({
			on_attach = on_attach_change,
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			filters = {
				dotfiles = true,
				git_ignored = false,
			},
			view = {
				number = true,
				relativenumber = true,
			},
			renderer = {
				indent_markers = {
					enable = true,
				},
				highlight_git = "name",
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
			},
		})

		vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", { silent = true, desc = "Open file tree" })
	end,
}
