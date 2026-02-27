return {
	"nvim-mini/mini.ai",
	event = "VeryLazy",
	dependencies = {
		{
			'nvim-mini/mini.extra',
			version = false,
			-- config = function() require('mini.extra').setup() end,
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
