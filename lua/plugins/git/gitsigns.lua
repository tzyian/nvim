return {
	-- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	opts = {
		-- See `:help gitsigns.txt`
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text_pos = 'right_align',
			delay = 0,
		},
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		on_attach = function(bufnr)
			local gs = require("gitsigns")

			-- Prefer word_diff over line_diff for changes
			vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { bg = nil })

			local function map(mode, key, func, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, key, func, opts)
			end

			-- Navigation
			map({ "n", "v" }, "]h", function()
				if vim.wo.diff then
					vim.cmd.normal({ ']c', bang = true })
				end
				vim.schedule(function()
					gs.nav_hunk("next")
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Jump to next hunk" })

			map({ "n", "v" }, "[h", function()
				if vim.wo.diff then
					vim.cmd.normal({ '[c', bang = true })
				end
				vim.schedule(function()
					gs.nav_hunk("prev")
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Jump to previous hunk" })

			-- Actions
			-- visual mode
			map("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "stage git hunk" })
			map("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "reset git hunk" })

			-- normal mode
			map("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })
			map("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })

			map("n", "<leader>hS", gs.stage_buffer, { desc = "git Stage buffer" })
			map("n", "<leader>hR", gs.reset_buffer, { desc = "git Reset buffer" })

			map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview git hunk inline" })
			map("n", "<leader>hi", gs.preview_hunk_inline, { desc = "Preview git hunk" })

			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, { desc = "git blame line" })

			map("n", "<leader>hd", gs.diffthis, { desc = "git diff against staged" })
			map("n", "<leader>hD", function()
				gs.diffthis("~")
			end, { desc = "git Diff against last commit" })
			map("n", "<leader>hE", function()
				gs.diffthis("master")
			end, { desc = "git Diff against master" })


			map('n', '<leader>hq', gs.setqflist, { desc = "Show git hunk list for current file" })
			map('n', '<leader>hQ', function() gs.setqflist('all') end, { desc = "Show git hunk list for repo" })

			-- Toggles
			-- moved to WhichKey

			-- Text object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
		end,
	},
}
