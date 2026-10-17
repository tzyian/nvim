return { -- Autoformat
	"stevearc/conform.nvim",
	dependencies = { "lewis6991/gitsigns.nvim" },
	event = { "BufWritePre", "BufNewFile" },
	lazy = true,
	cmd = { "ConformInfo", "ToggleBufferFormat", "ToggleGlobalFormat", "Format" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			desc = "Format buffer",
		},
		{
			"<leader>mf",
			"<cmd>ConformInfo<CR>",
			desc = "Conform info",
		},
	},
	config = function()
		local conform = require("conform")
		local gitsigns = require("gitsigns")

		-- source: https://github.com/stevearc/conform.nvim/issues/92
		local global_format = { "lua" }
		local function format_git_hunks(bufnr)
			if vim.tbl_contains(global_format, vim.bo.filetype) then
				conform.format({ lsp_fallback = true, timeout_ms = 500 })
				return
			end
			local hunks = gitsigns.get_hunks(bufnr)
			if not hunks then
				local status = vim.b[bufnr].gitsigns_status_dict
				if not status or status.added ~= nil then
					return
				end
				hunks = {
					{
						type = "untracked",
						added = { start = 0, count = vim.api.nvim_buf_line_count(bufnr) },
					},
				}
			end

			-- Format bottom-up so a formatter changing line counts cannot shift later ranges.
			for i = #hunks, 1, -1 do
				local hunk = hunks[i]
				if hunk.type ~= "delete" then
					local start = math.max(1, hunk.added.start)
					local last = start + hunk.added.count
					local last_line = vim.api.nvim_buf_get_lines(bufnr, last - 2, last - 1, false)[1] or ""
					conform.format({
						bufnr = bufnr,
						async = false,
						lsp_format = "fallback",
						timeout_ms = 500,
						range = {
							start = { start, 0 },
							["end"] = { last - 1, #last_line },
						},
					})
				end
			end
		end

		conform.setup({
			format_on_save = false,
			notify_on_error = false,
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				-- lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				python = { "ruff_format", "ruff_organize_imports"
					-- "ruff_fix", -- disable because it removes unused imports if not configured otherwise
				},
				rust = { "rustfmt" },
				go = { "golines", "gofumpt", },
				sh = { "shfmt", "shellharden" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				bib = { "bibtex-tidy" },
				-- java = { "google-java-format" },
				-- latex = { "latexindent" },
				-- ocaml = { "ocamlformat" },
				sql = { "sqruff" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "yamlfmt" },
				typst = { "typstyle" }
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function(args)
				if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
					return
				end
				format_git_hunks(args.buf)
			end,
		})

		vim.api.nvim_create_user_command("ToggleBufferFormat", function(args)
			if vim.b.disable_autoformat then
				vim.b.disable_autoformat = false
			else
				vim.b.disable_autoformat = true
			end
		end, {
			desc = "Toggle format on save (buffer)",
			bang = true,
		})
		vim.api.nvim_create_user_command("ToggleGlobalFormat", function(args)
			if vim.g.disable_autoformat then
				vim.g.disable_autoformat = false
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Toggle format on save (global)",
			bang = true,
		})

		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end
			require("conform").format({ async = true, lsp_format = "fallback", range = range })
		end, { range = true })
	end,
}
