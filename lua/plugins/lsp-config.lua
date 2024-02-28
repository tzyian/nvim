return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},

	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim",       opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
		config = function()
			local servers = {
				-- jdtls = {
				-- 	filetypes = { "java" },
				-- },
				clangd = {
					cmd = {
						"clangd",
						"--offset-encoding=utf-16",
					},
				},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- tsserver = {},
				-- html = { filetypes = { 'html', 'twig', 'hbs'} },

				lua_ls = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						diagnostics = {
							globals = { "vim" },
							-- disable = { "missing-fields" }
						},
					},
				},
			}

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- Ensure the servers above are installed
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						-- on_attach = on_attach,
						settings = servers[server_name],
						filetypes = (servers[server_name] or {}).filetypes,
					})
				end,
			})

			-- Switch for controlling whether you want autoformatting.
			--  Use :KickstartFormatToggle to toggle autoformatting on or off
			local format_is_enabled = true
			vim.api.nvim_create_user_command("KickstartFormatToggle", function()
				format_is_enabled = not format_is_enabled
				print("Setting autoformatting to: " .. tostring(format_is_enabled))
			end, {})
			vim.keymap.set({ "n", "v" }, "<leader>ct", ":KickstartFormatToggle<CR>", { desc = "Toggle Format" })

			-- Create an augroup that is used for managing our formatting autocmds.
			--      We need one augroup per client to make sure that multiple clients
			--      can attach to the same buffer without interfering with each other.
			local _augroups = {}
			local get_augroup = function(client)
				if not _augroups[client.id] then
					local group_name = "kickstart-lsp-format-" .. client.name
					local id = vim.api.nvim_create_augroup(group_name, { clear = true })
					_augroups[client.id] = id
				end

				return _augroups[client.id]
			end

			-- Whenever an LSP attaches to a buffer, we will run this function.
			--
			-- See `:help LspAttach` for more information about this autocmd event.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach-format", { clear = true }),
				-- This is where we attach the autoformatting for reasonable clients
				callback = function(args)
					local client_id = args.data.client_id
					local client = vim.lsp.get_client_by_id(client_id)
					local bufnr = args.buf

					-- Only attach to clients that support document formatting
					if not client.server_capabilities.documentFormattingProvider then
						return
					end

					-- Tsserver usually works poorly. Sorry you work with bad languages
					-- You can remove this line if you know what you're doing :)
					if client.name == "tsserver" then
						return
					end

					-- Create an autocmd that will run *before* we save the buffer.
					--  Run the formatting command for the LSP that has just attached.
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = get_augroup(client),
						buffer = bufnr,
						callback = function()
							if not format_is_enabled then
								return
							end

							vim.lsp.buf.format({
								async = false,
								filter = function(c)
									return c.id == client.id
								end,
							})
						end,
					})
				end,
			})

			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[R]ename" })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show [K]ind" })
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "[G]o [D]efinition" })
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "[G]o [R]eferences" })
			vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "[G]o [I]mplementation" })

			vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "[G]o [T]ype Definition" })

			vim.keymap.set("n", "<leader>cs", vim.lsp.buf.document_symbol, { desc = "[C]ode Document [S]ymbols" })

			vim.keymap.set("n", "<leader>gs", vim.lsp.buf.signature_help, { desc = "[G]o [S]ignature Help" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
			vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode [F]ormat" })
		end,
	},
}
