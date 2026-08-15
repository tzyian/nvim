return {
	"folke/which-key.nvim",
	event = "VimEnter",
	init = function()
		if vim.g.barbecue_enabled == nil then
			vim.g.barbecue_enabled = true
		end
		if vim.g.context_enabled == nil then
			vim.g.context_enabled = true
		end
		require("which-key-additions")
	end,
	opts = {
		delay = 0,
		spec = {
			{ "<leader>b",  group = "Buffer" },
			{ "<leader>c",  group = "Code",            mode = { "n", "v" } },
			{ "<leader>ct", group = "Toggle format" },
			{ "<leader>d",  group = "Debug" },
			{ "<leader>f",  group = "Find" },
			{ "<leader>g",  group = "GoTo" },
			{ "<leader>h",  group = "Git Hunk",        mode = { "n", "v" } },
			{ "<leader>ht", group = "Git Toggles" },
			{ "<leader>l",  group = "FileType" },
			{ "<leader>m",  group = "Misc Config" },
			{ "<leader>n",  "<cmd>NvimTreeToggle<CR>", desc = "Open file tree" },
			{ "<leader>p",  group = "Preview / UI" },
			{ "<leader>q",  group = "Diagnostics" },
			{ "<leader>r",  group = "SnipRun",         mode = { "n", "v" } },
			{ "<leader>s",  group = "Session" },
			{ "<leader>S",  group = "sshfs" },
			{ "<leader>t",  group = "Terminal" },
			{ "<leader>z",  group = "Leet" },
			{ "<leader>fl", group = "Lsp" },
			{ "<leader>fh", group = "Git" },

			-- =============================================
			-- CODE & LSP TOGGLES (<leader>c*)
			-- =============================================
			{
				"<leader>cc",
				function()
					vim.g.context_enabled = not vim.g.context_enabled
					vim.cmd("TSContext toggle")
				end,
				desc = "Toggle Context",
				icon = function()
					local active = package.loaded["treesitter-context"]
							and require("treesitter-context").enabled()
							or vim.g.context_enabled
					return active and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
				end,
			},
			{
				"<leader>cb",
				function()
					vim.g.barbecue_enabled = not vim.g.barbecue_enabled
					require("barbecue.ui").toggle()
				end,
				desc = "Toggle Breadcrumbs",
				icon = function()
					return vim.g.barbecue_enabled and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
				end,
			},
			{
				"<leader>ci",
				function()
					if vim.lsp.inlay_hint then
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
					end
				end,
				desc = "Toggle Inlay Hints",
				icon = function()
					local active = vim.lsp.inlay_hint and vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
					return active and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
				end,
			},
			{
				"<leader>cl",
				function()
					local bufnr = vim.api.nvim_get_current_buf()
					vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
				end,
				desc = "Toggle Code Lens",
				icon = function()
					local active = vim.lsp.codelens.is_enabled({ bufnr = 0 })
					return active and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
				end,
			},
			{
				"<leader>cq",
				function()
					vim.diagnostic.config({
						virtual_lines = not vim.diagnostic.config().virtual_lines,
					})
				end,
				desc = "Toggle Diagnostic Virtual Lines",
				icon = function()
					local active = vim.diagnostic.config().virtual_lines == true
					return active and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
				end,
			},
			{
				"<leader>cg",
				"<cmd>ToggleBufferFormat<CR>",
				desc = "Toggle Autoformat (Buffer)",
				icon = function()
					return not vim.b.disable_autoformat and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
				end,
			},
			{
				"<leader>cG",
				"<cmd>ToggleGlobalFormat<CR>",
				desc = "Toggle Autoformat (Global)",
				icon = function()
					return not vim.g.disable_autoformat and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
				end,
			},

			-- =============================================
			-- GIT TOGGLES (<leader>ht*)
			-- =============================================
			{
				"<leader>htb",
				function() require("gitsigns").toggle_current_line_blame() end,
				desc = "Toggle Git Blame Line",
				icon = function()
					local active = package.loaded.gitsigns and require("gitsigns.config").config.current_line_blame
					return active and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
				end,
			},
			{
				"<leader>htd",
				function() require("gitsigns").toggle_deleted() end,
				desc = "Toggle Git Show Deleted",
				icon = function()
					local active = package.loaded.gitsigns and require("gitsigns.config").config.show_deleted
					return active and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
				end,
			},
			{
				"<leader>htw",
				function() require("gitsigns").toggle_word_diff() end,
				desc = "Toggle Git Word Diff",
				icon = function()
					local active = package.loaded.gitsigns and require("gitsigns.config").config.word_diff
					return active and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
				end,
			},

			-- =============================================
			-- PREVIEW & UI TOGGLES (<leader>p*)
			-- =============================================
			{
				"<leader>pm",
				"<cmd>RenderMarkdown toggle<CR>",
				desc = "Toggle Render Markdown",
				icon = function()
					local active = package.loaded["render-markdown"] and require("render-markdown.state").enabled
					return active and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
				end,
			},
			{
				"<leader>pv",
				"<cmd>CsvViewToggle<CR>",
				desc = "Toggle CSV View",
				icon = function()
					local active = package.loaded["csvview"] and require("csvview").is_enabled()
					return active and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
				end,
			},
			{
				"<leader>pz",
				"<cmd>ZenMode<CR>",
				desc = "Toggle Zen Mode",
				icon = function()
					local active = package.loaded["zen-mode.view"] and require("zen-mode.view").is_open()
					return active and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
				end,
			},
			{
				"<leader>pl",
				"<cmd>Limelight!!<CR>",
				desc = "Toggle Limelight",
				icon = function()
					local active = vim.fn.exists("#limelight") == 1
					return active and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
				end,
			},
		},
	},
}
