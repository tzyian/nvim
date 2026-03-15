return {
	{
		"neovim/nvim-lspconfig",
		-- lazy = false,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "mason-org/mason.nvim",                      opts = {} },
			{ "williamboman/mason-lspconfig.nvim", },
			{ 'WhoIsSethDaniel/mason-tool-installer.nvim', },
			{ "p00f/clangd_extensions.nvim" },

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim",                         opts = {} },
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
									'${3rd}/luv/library',
									'${3rd}/busted/library',
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

			require('mason-tool-installer').setup { ensure_installed = ensure_installed }

			for name, server in pairs(servers) do
				vim.lsp.config(name, server)
				vim.lsp.enable(name)
			end

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

					if client and client:supports_method('textDocument/inlayHint', event.buf) then
						vim.lsp.inlay_hint.enable()
						vim.keymap.set("n", "<leader>ci",
							function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
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
