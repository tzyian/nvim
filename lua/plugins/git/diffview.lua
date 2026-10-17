return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh", "DiffviewFileHistory" },
	opts = {
		keymaps = {
			view = {
				{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
			},
			file_panel = {
				{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
			},
			file_history_panel = {
				{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
			},
		},
	},

	keys = function()
		local function open_diff(revision, files)
			local args = revision and { revision } or {}
			if files then
				table.insert(args, "--")
				vim.list_extend(args, files)
			end
			vim.cmd({ cmd = "DiffviewOpen", args = args })
		end

		local function open_revision_picker(picker, files)
			local picker_fn = (picker == "git_branches") and Snacks.picker.git_branches or Snacks.picker.git_log
			picker_fn({
				confirm = function(p, item)
					p:close()
					local selected = p:selected()
					if #selected == 2 then
						local r1 = selected[1].commit or selected[1].branch
						local r2 = selected[2].commit or selected[2].branch
						if r1 and r2 then
							open_diff(r2 .. ".." .. r1, files)
							return
						end
					end
					if not item then return end
					local revision = item.branch or item.commit
					if not revision then
						vim.notify("Could not read selected Git revision", vim.log.levels.ERROR)
						return
					end
					open_diff(revision, files)
				end,
			})
		end

		local function get_buffers()
			local files, seen = {}, {}
			for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
				local name = vim.api.nvim_buf_get_name(bufnr)
				if vim.api.nvim_buf_is_loaded(bufnr)
						and vim.bo[bufnr].buflisted
						and name ~= ""
						and vim.fn.filereadable(name) == 1
						and not seen[name] then
					table.insert(files, name)
					seen[name] = true
				end
			end
			return files
		end

		local function diff_buffers(revision)
			open_diff(revision, get_buffers())
		end

		local function default_base_branch()
			for _, branch in ipairs({ "master", "main" }) do
				local result = vim.system({ "git", "rev-parse", "--verify", "--quiet", "refs/heads/" .. branch }, { text = true })
						:wait()
				if result.code == 0 then
					return branch
				end
			end
		end

		local function diff_master(files)
			local branch = default_base_branch()
			if branch then
				open_diff(branch .. "..HEAD", files)
			else
				open_revision_picker("git_branches", files)
			end
		end

		return {
			-- Index
			{ "<leader>hd", "<cmd>DiffviewOpen<cr>",                     desc = "Diff index (repo)" },
			{ "<leader>hD", function() diff_buffers(nil) end,            desc = "Diff index (buffers)" },

			-- Last commit
			{ "<leader>hl", "<cmd>DiffviewOpen HEAD~1..HEAD<cr>",        desc = "Diff last commit (repo)" },
			{ "<leader>hL", function() diff_buffers("HEAD~1..HEAD") end, desc = "Diff last commit (buffers)" },

			--- Master
			{
				"<leader>hm",
				function() diff_master() end,
				desc = "Diff master (repo)"
			},
			{
				"<leader>hM",
				function() diff_master(get_buffers()) end,
				desc = "Diff master (buffers)",
			},

			-- Branches
			{
				"<leader>hf",
				function() open_revision_picker("git_branches") end,
				desc = "Diff branch (repo)",
			},
			{
				"<leader>hF",
				function() open_revision_picker("git_branches", get_buffers()) end,
				desc = "Diff branch (buffers)",
			},

			-- Commits
			{
				"<leader>hc",
				function() open_revision_picker("git_commits") end,
				desc = "Diff commit (repo)",
			},
			{
				"<leader>hC",
				function() open_revision_picker("git_commits", get_buffers()) end,
				desc = "Diff commit (buffers)",
			},

			-- History
			{
				"<leader>hh",
				"<cmd>DiffviewFileHistory %<cr>",
				mode = { "n", "v" },
				desc = "git history (file)",
			},
			{ "<leader>hH", "<cmd>DiffviewFileHistory<cr>", desc = "git history (repo)" },

		}
	end,
}
