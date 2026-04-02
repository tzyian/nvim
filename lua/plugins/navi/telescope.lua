return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			-- { "nvim-telescope/telescope-frecency.nvim", }
		},
		config = function()
			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			--
			--  Show keymaps within Telescope
			--  - Insert mode: <c-/>
			-- Normal mode: ?
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				defaults = {
					layout_config = {
						horizontal = {
							preview_cutoff = 0,
						},
					},
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
							["<C-p>"] = require("telescope.actions.layout").toggle_preview,
						},
					},
				},
			})
			local builtin = require("telescope.builtin")

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			-- pcall(require("telescope").load_extension, "frecency")
			-- pcall(require('telescope').load_extension('ht'))

			-- Telescope live_grep in git root
			-- Function to find the git root directory based on the current buffer's path
			local function find_git_root()
				-- Use the current buffer's path as the starting point for the git search
				local current_file = vim.api.nvim_buf_get_name(0)
				local current_dir
				local cwd = vim.fn.getcwd()
				-- If the buffer is not associated with a file, return nil
				if current_file == "" then
					current_dir = cwd
				else
					-- Extract the directory from the current file's path
					current_dir = vim.fn.fnamemodify(current_file, ":h")
				end

				-- Find the Git root directory from the current file's path
				local git_root =
						vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")
				if vim.v.shell_error ~= 0 then
					print("Not a git repository. Searching on current working directory")
					return cwd
				end
				return git_root
			end

			-- Custom live_grep function to search in git root

			vim.api.nvim_create_user_command("LiveGrepGitRoot", function()
				local git_root = find_git_root()
				if git_root then
					builtin.live_grep({
						search_dirs = { git_root },
					})
				end
			end, {})

			local function telescope_live_grep_open_files()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end

			local function telescope_buffers()
				builtin.buffers({
					sort_mru = true,
					ignore_current_buffer = true,
				})
			end

			-- See `:help telescope.builtin`

			-- Buffers and Files
			nmap("<leader>ff", builtin.find_files, "Find Files")
			-- frecency is still noticeably slower...
			-- nmap("<leader>ff", "<cmd>Telescope frecency workspace=CWD<cr>", "Find Files")
			nmap("<leader>fo", builtin.oldfiles, "? Find recently opened files")
			nmap("<leader><space>", telescope_buffers, "  Find existing buffers")
			nmap("<leader>bb", telescope_buffers, "Buffers browse")

			-- Grep
			-- nmap("<leader>f/", telescope_live_grep_open_files, "Find / in Open Files")
			-- nmap("<leader>/", function()
			-- 	-- You can pass additional configuration to telescope to change theme, layout, etc.
			-- 	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			-- 		winblend = 10,
			-- 		previewer = false,
			-- 	}))
			-- end, "/ Fuzzily search in current buffer")
			-- nmap("<leader>fw", builtin.grep_string, "Find current Word")

			nmap("<leader>fg", builtin.live_grep, "Find by Grep")

			-- Git
			nmap("<leader>fhf", builtin.git_files, "Find git files")
			nmap("<leader>fhc", builtin.git_commits, "Find git commits")
			nmap("<leader>fhr", "<cmd>LiveGrepGitRoot<cr>", "Find by Grep on Git Root")

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
				callback = function(event)
					local buf = event.buf

					-- Lsp
					nmap("gr", builtin.lsp_references, "Go References", { buffer = buf })
					nmap("<leader>gr", builtin.lsp_references, "Go References", { buffer = buf })
					nmap("gd", builtin.lsp_definitions, "Go Definitions", { buffer = buf })
					nmap("<leader>gd", builtin.lsp_definitions, "Go Definitions", { buffer = buf })
					nmap("gD", builtin.lsp_type_definitions, "Go Type Definitions", { buffer = buf })
					nmap("<leader>gD", builtin.lsp_type_definitions, "Go Type Definitions", { buffer = buf })
					nmap("gi", builtin.lsp_implementations, "Go Implementations", { buffer = buf })
					nmap("<leader>gi", builtin.lsp_implementations, "Go Implementations", { buffer = buf })

					nmap("<leader>gn", builtin.lsp_incoming_calls, "Find Incoming", { buffer = buf })
					nmap("<leader>gg", builtin.lsp_outgoing_calls, "Find Outgoing", { buffer = buf })

					nmap("<leader>fs", builtin.lsp_document_symbols, "Find Document Symbols", { buffer = buf })
					nmap("<leader>fS", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols", { buffer = buf })
				end,
			})

			-- Diagnostics
			nmap("<leader>fd", builtin.diagnostics, "Find Diagnostics")
			nmap("<leader>fq", builtin.quickfix, "Find quickfix")

			-- Marks
			nmap("<leader>fm", builtin.marks, "Find marks")

			-- Misc
			nmap("<leader>fr", builtin.resume, "Find Resume")
			nmap("<leader>fx", builtin.builtin, "Find Select Telescope")
			-- nmap("<leader>fk", builtin.keymaps, "Find Keymaps")
			-- nmap("<leader>ft", builtin.treesitter, "Find treesitter")
			-- nmap("<leader>fH", builtin.help_tags, "Find Help")
			nmap("<leader>f:", builtin.command_history, "Find Command History")
			nmap("<leader>fc", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, "Find Config")
			-- nmap("<leader>fp", function()
			-- 	builtin.planets({ show_pluto = true, show_moon = true })
			-- end, "Find Planets")
		end,
	},
}
