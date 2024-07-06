return {
	{
		"neovim/nvim-lspconfig",
		-- lazy = false,
		event = "BufReadPre",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim",           opts = {} },
			{ "williamboman/mason-lspconfig.nvim", opts = {} },

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
					},
					on_attach = function()
						vim.keymap.set(
							"n",
							"<leader>ch",
							"<cmd>ClangdSwitchSourceHeader<CR>",
							{ desc = "ClangdSwitchSourceHeader" }
						)
					end,
				},
				-- gopls = {},
				pylsp = {
					settings = {
						pylsp = {
							plugins = {
								-- formatter
								autopep8 = { enabled = false },
								yapf = { enabled = false },
								-- linter
								pycodestyle = {
									enabled = true,
									-- ignore = { "E501" },
									-- maxLineLength = 100,
								},
							},
						},
					},
				},
				-- rust_analyzer = {},
				-- tsserver = {},
				-- html = { filetypes = { 'html', 'twig', 'hbs'} },

				ocamllsp = {
					-- This doesn't seem to be working eh
					settings = {
						ocamllsp = {
							extendedHover = { enable = true },
							codelens = { enable = true },
							inlayHints = { enable = true },
							syntaxDocumentation = { enable = true },
						},
					},
				},
				texlab = {
					chktex = {
						onOpenAndSave = true,
						onEdit = true,
					},
				},
				lua_ls = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						diagnostics = {
							globals = { "vim" },
							disable = { "missing-fields" },
						},
					},
				},
			}

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Ensure the servers above are installed
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers or {}),
				handlers = {
					function(server_name)
						if server_name == "rust_analyzer" then
							return
						end

						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[R]ename" }),
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" }),
				vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode [F]ormat" }),
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show [K]ind" }),
				vim.keymap.set("i", "<C-k>", vim.lsp.buf.hover, { desc = "Show [K]ind" }),

				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)

					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						vim.lsp.inlay_hint.enable()
						vim.keymap.set("n", "<leader>ci", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, { desc = "Toggle Inlay Hints" })
					end

					if client and client.server_capabilities.codeLensProvider and vim.lsp.codelens then
						vim.lsp.codelens.refresh()
						vim.keymap.set(
							"n",
							"<leader>cl",
							vim.lsp.codelens.refresh,
							{ desc = "[C]ode [L]ens", silent = true }
						)
						vim.keymap.set(
							"n",
							"<leader>cL",
							vim.lsp.codelens.clear,
							{ desc = "[C]ode [L]ens Clear", silent = true }
						)
					end
				end,
			})
		end,
	},
}
