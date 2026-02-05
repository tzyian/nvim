return {
	{
		"neovim/nvim-lspconfig",
		-- lazy = false,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim",           opts = {}, cmd = "Mason" },
			{ "williamboman/mason-lspconfig.nvim", opts = {} },
			{ "p00f/clangd_extensions.nvim" },

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim",                 opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
		config = function()
			local servers = {
				-- jdtls = {
				-- 	filetypes = { "java" },
				-- },
				clangd = {
					capabilities = {
						offsetEncoding = { "utf-16" },
					},
					cmd = {
						"clangd",
						"--offset-encoding=utf-16",
						"--extra-arg=-std=c++20",
					},
				},
				elixirls = {
					cmd = { "elixir-ls" },
				},
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
							-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							diagnostics = {
								globals = { "vim" },
								-- disable = { "missing-fields" },
							},
						},
					},
				},
			}

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers or {}),
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						vim.lsp.config(server_name, server)
						vim.lsp.enable(server_name)
					end,
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local bufnr = event.buf
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
					-- vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { buffer = bufnr, desc = "Code Format" })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show Kind" })
					vim.keymap.set("i", "<C-k>", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show Kind" })

					-- Clangd-specific keymap
					if client and client.name == "clangd" then
						vim.keymap.set(
							"n",
							"<leader>ch",
							"<cmd>ClangdSwitchSourceHeader<CR>",
							{ buffer = bufnr, desc = "Switch Source/Header" }
						)
					end

					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						vim.lsp.inlay_hint.enable()
						vim.keymap.set("n", "<leader>ci", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, { desc = "Toggle Inlay Hints" })

						require("which-key").add({
							{
								"<leader>ci",
								"<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
								desc = "Toggle Inlay Hints",
								icon = function()
									if vim.lsp.inlay_hint.is_enabled() then
										return { icon = " ", color = "green" }
									else
										return { icon = " ", color = "yellow" }
									end
								end,
							},
						})
					end

					if client and client.server_capabilities.codeLensProvider and vim.lsp.codelens then
						vim.lsp.codelens.refresh()
						vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.refresh, { desc = "Code Lens" })
						vim.keymap.set("n", "<leader>cL", vim.lsp.codelens.clear, { desc = "Code Lens Clear" })
					end
				end,
			})
		end,
	},
}
