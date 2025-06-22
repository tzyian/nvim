return {
	"echasnovski/mini.ai",
	event = "VeryLazy",
	dependencies = {
		{
			'echasnovski/mini.extra',
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
				-- f = function call (builtin)
				-- a = argument (builtin)
				-- t = tags (builtin)
				-- { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
				--
				o = ai.gen_spec.treesitter({ -- code block
					a = { "@block.outer", "@conditional.outer", "@loop.outer" },
					i = { "@block.inner", "@conditional.inner", "@loop.inner" },
				}),
				i = spec.indent(),
				F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
				c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),   -- class
				d = { "%f[%d]%d+" },                                                      -- digits
				e = {                                                                     -- Word with case
					{ "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
					"^().*()$",
				},
				g = function()
					-- Global
					local from = { line = 1, col = 1 }
					local to = {
						line = vim.fn.line("$"),
						col = math.max(vim.fn.getline("$"):len(), 1),
					}
					return { from = from, to = to }
				end,
				["$"] = { "^.*$" },
			},
			u = ai.gen_spec.function_call(),                        -- u for "Usage"
			U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
		}
	end,
	config = function(_, opts)
		require("mini.ai").setup(opts)
	end,
}
