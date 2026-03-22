return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "BufReadPost", "BufNewFile" },
		branch = "main",
		keys = {
			{
				"<leader><Left>",
				function()
					require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.inner"
				end,
				desc = "Swap previous parameter"
			},
			{
				"<leader><Right>",
				function()
					require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
				end,
				desc = "Swap next parameter"
			},
		},
		config = function(_, opts)
			require("nvim-treesitter-textobjects").setup({
				select = {
					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,
					include_surrounding_whitespace = false,
				},
			})
		end,
	},

	{
		"nvim-mini/mini.ai",
		event = "VeryLazy",
		dependencies = {
			{
				'nvim-mini/mini.extra',
				version = false,
			},
		},
		opts = function()
			local ai = require("mini.ai")
			local spec = require('mini.extra').gen_ai_spec
			return {
				n_lines = 50,
				custom_textobjects = {
					-- f = function call (builtin) i.e. foo(inside here)
					-- a = argument (builtin) def foo(arg1: type, arg2: type)
					-- t = tags (builtin)
					-- { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },

					-- code block
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					-- function definition
					F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
					-- class
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),

					-- Word for camelCase or snake_case
					e = {
						{
							'%u[%l%d]+%f[^%l%d]',
							'%f[%S][%l%d]+%f[^%l%d]',
							'%f[%P][%l%d]+%f[^%l%d]',
							'^[%l%d]+%f[^%l%d]',
						},
						'^().*()$'
					},

					d = spec.number(),
					D = spec.diagnostic(),
					i = spec.indent(),
					g = spec.buffer(),
					["$"] = spec.line(), -- { "^.*$" },

					-- start of line
					H = function()
						local l = vim.fn.line(".")
						local c = vim.fn.col(".")
						local from = { line = l, col = 1 }
						local to = { line = l, col = c }
						return { from = from, to = to }
					end,
					-- end of line
					L = { ".*" },
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
		end,
	}
}
