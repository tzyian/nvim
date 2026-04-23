return {
	{
		"saghen/blink.cmp",
		dependencies = {
			{ "fang2hou/blink-copilot" },
			{ "rafamadriz/friendly-snippets" },
			{
				'L3MON4D3/LuaSnip',
				version = '2.*',
				build = (function()
					if vim.fn.executable 'make' == 0 then return end
					return 'make install_jsregexp'
				end)(),
				-- -- Show virtual text if there are choice nodes
				-- config = function()
				-- 	local types = require("luasnip.util.types")
				-- 	require 'luasnip'.config.setup({
				-- 		ext_opts = {
				-- 			[types.choiceNode] = {
				-- 				active = {
				-- 					virt_text = { { "●", "RainbowOrange" } }
				-- 				}
				-- 			},
				-- 			[types.insertNode] = {
				-- 				active = {
				-- 					virt_text = { { "●", "RainbowBlue" } }
				-- 				}
				-- 			}
				-- 		}
				-- 	})
				-- end

				-- -- Keymaps:
				-- local ls = require("luasnip")
				-- if ls.choice_active() then
				-- 	ls.change_choice(1)
				-- end
			},

		},
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			keymap = {
				preset = "none",
				["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "cancel", "fallback" },
				['<C-y>'] = { 'select_and_accept', 'fallback' },
				["<CR>"] = { "accept", "fallback" },

				['<Up>'] = { 'select_prev', 'fallback' },
				['<Down>'] = { 'select_next', 'fallback' },
				['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
				['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

				['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
			},
			snippets = { preset = "luasnip", },
			signature = { enabled = true, },
			completion = {
				trigger = {
					show_in_snippet = false,
				},
				list = {
					selection = {
						-- press Tab to select the first item
						preselect = false
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 0,
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "copilot", },
				per_filetype = {
					gitcommit = { "git", "buffer" },
					-- Disable buffer for text filetypes
					typst = { "lsp", "snippets", "copilot" },
					markdown = { "lsp", "snippets", "copilot" },
					text = { "lsp", "snippets", "copilot" },
				},
				providers = {
					path = {
						opts = {
							get_cwd = function(_)
								-- path from cwd e.g. git root rather than buffer parent
								return vim.fn.getcwd()
							end,
						},
					},
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						async = true,
						enabled = function()
							return not require("copilot.client").is_disabled()
						end,
					},
				},
			},
			cmdline = {
				completion = {
					list = {
						selection = {
							preselect = false
						}
					},
					menu = {
						auto_show = true,
					}
				},
				sources = function()
					local type = vim.fn.getcmdtype()
					if type == "/" or type == "?" then
						return { "buffer" }
					end
					if type == ":" then
						return { "path", "cmdline" }
					end
					return {}
				end,
			},
		},
		config = function(_, opts)
			require("plugins.code.dynamic-completions")
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
			require("blink.cmp").setup(opts)
		end,
	},
}
