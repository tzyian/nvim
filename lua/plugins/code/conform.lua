-- return {}
return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufNewFile" },
	lazy = true,
	cmd = { "ConformInfo" },
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
		require("conform").setup({
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_fallback = true }
			end,

			notify_on_error = false,
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				python = { "isort", "black" },
				go = { "golines", "goimports" },
				sh = { "shfmt", "shellharden" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				-- java = { "google-java-format" },
				latex = { "latexindent" },
				ocaml = { "ocamlformat" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				xml = { "xmlformatter" },
				yaml = { "yamlfmt" },
			},
		})

		------ Moved to which-key.lua
		-- require("which-key").add({
		--   {
		--     "<leader>cg",
		--     "<cmd>ToggleBufferFormat<CR>",
		--     desc = "Toggle format on save (buffer)",
		--     icon = function()
		--       if vim.b.disable_autoformat then
		--         return { icon = " ", color = "yellow" }
		--       else
		--         return { icon = " ", color = "green" }
		--       end
		--     end,
		--   },
		--   {
		--     "<leader>cG",
		--     "<cmd>ToggleGlobalFormat<CR>",
		--     desc = "Toggle format on save (global)",
		--     icon = function()
		--       if vim.g.disable_autoformat then
		--         return { icon = " ", color = "yellow" }
		--       else
		--         return { icon = " ", color = "green" }
		--       end
		--     end,
		--   },
		-- })

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
