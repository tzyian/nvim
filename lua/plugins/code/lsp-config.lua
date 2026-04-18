return {
	{
		"neovim/nvim-lspconfig",
		-- lazy = false,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "mason-org/mason.nvim",              opts = {} },
			{ "williamboman/mason-lspconfig.nvim", },
			-- { 'WhoIsSethDaniel/mason-tool-installer.nvim', },
			{ "p00f/clangd_extensions.nvim" },

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim",                 opts = {} },
		},
		config = function()
			local servers = {
				-- jdtls = {
				-- 	filetypes = { "java" },
				-- },
				gopls = {},
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
				copilot = {
					settings = {
						telemetry = {
							telemetryLevel = "off"
						},
					}
				},
				elixirls = {
					cmd = { "elixir-ls" },
				},
				lua_ls = {
					on_init = function(client)
						if client.workspace_folders then
							local path = client.workspace_folders[1].name
							if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
						end

						client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
							runtime = {
								version = 'LuaJIT',
								path = { 'lua/?.lua', 'lua/?/init.lua' },
							},
							workspace = {
								checkThirdParty = false,
								-- NOTE: this is a lot slower and will cause issues when working on your own configuration.
								--  See https://github.com/neovim/nvim-lspconfig/issues/3189
								library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
									vim.env.VIMRUNTIME,
									'${3rd}/luv/library',
								}),
							},
							diagnostics = {
								globals = { "vim" }
							}
						})
					end,
					settings = {
						Lua = {},
					},
				},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				-- You can add other tools here that you want Mason to install
			})

			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				automatic_enable = {
					exclude = { "rust_analyzer" },
				},
				ensure_installed = vim.tbl_keys(servers or {}),
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						vim.lsp.config(server_name, server)
						vim.lsp.enable(server_name)
					end,
				},
			})


			-- require('mason-tool-installer').setup { ensure_installed = ensure_installed }

			-- for name, server in pairs(servers) do
			-- 	vim.lsp.config(name, server)
			-- 	vim.lsp.enable(name)
			-- end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)
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

					-- Tinymist: allow labels to work in multi-file setups
					local name = vim.fs.basename(vim.api.nvim_buf_get_name(args.buf))
					if client and client.name == "tinymist" then
						function pinBuffer()
							client:exec_cmd({
								title = "pin",
								command = "tinymist.pinMain",
								arguments = { vim.api.nvim_buf_get_name(bufnr) },
							}, { bufnr = bufnr })
						end

						function unpinBuffer()
							client:exec_cmd({
								title = "unpin",
								command = "tinymist.pinMain",
								arguments = { vim.v.null },
							}, { bufnr = bufnr })
						end

						if name == "main.typ" then
							pinBuffer()
						end

						vim.keymap.set("n", "<leader>pt", pinBuffer, { buffer = bufnr, desc = "Tinymist pin" })

						vim.keymap.set("n", "<leader>pT", unpinBuffer, { buffer = bufnr, desc = "Tinymist Unpin" })
					end

					if client and client:supports_method('textDocument/inlayHint', args.buf) then
						vim.lsp.inlay_hint.enable()
						vim.keymap.set("n", "<leader>ci",
							function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = args.buf }) end,
							{ desc = "Toggle Inlay Hints" })

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

					local filetype = vim.bo[bufnr].filetype
					if filetype ~= "typst" and client and client:supports_method('textDocument/codeLens', args.buf) then
						-- tinymist has codelens for typst but causes problems here for some reason
						vim.lsp.codelens.enable(true, { bufnr = bufnr })
						local function toggle_codelens()
							vim.lsp.codelens.enable(
								not vim.lsp.codelens.is_enabled({ bufnr = bufnr }),
								{ bufnr = bufnr }
							)
						end

						vim.keymap.set("n", "<leader>cl", toggle_codelens, { desc = "Toggle Code Lens" })
						vim.keymap.set("n", "<leader>cR", vim.lsp.codelens.run, { desc = "Code Lens Run" })
					end
				end,
			})
		end,
	},
}
