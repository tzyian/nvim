return {
  "sindrets/diffview.nvim",
  command = "DiffviewOpen",
  -- cond = is_git_root,
  opts = {
    keymaps = {
      view = {
        { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close help menu" } },
      },
      file_panel = {
        { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close help menu" } },
      },
      file_history_panel = {
        { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close help menu" } },
      },
    },
  },

  keys = function()
    local function diff_repo_revision(file)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local builtin = require("telescope.builtin")

      builtin.git_commits({
        attach_mappings = function(bufnr, _)
          actions.select_default:replace(function()
            actions.close(bufnr)
            local selection = action_state.get_selected_entry()
            if selection and selection.value then
              if file then
                vim.cmd("DiffviewOpen " .. selection.value .. " -- " .. file)
              else
                vim.cmd("DiffviewOpen " .. selection.value)
              end
            end
          end)
          return true
        end,
      })
    end

    return {
      {
        "<leader>hd",
        "<cmd>DiffviewOpen<cr>",
        desc = "Diff index",
      },
      {
        "<leader>hD",
        "<cmd>DiffviewOpen HEAD~1<cr>",
        desc = "Diff last commit",
      },
      {
        "<leader>hm",
        "<cmd>DiffviewOpen master..HEAD<cr>",
        desc = "Diff master",
      },
      {
        "<leader>hh",
        "<cmd>DiffviewFileHistory %<cr>",
        mode = { "n", "v" },
        desc = "File history",
      },
      {
        "<leader>hH",
        "<cmd>DiffviewFileHistory<cr>",
        desc = "Repo history",
      },
      {
        "<leader>hc",
        function()
          diff_repo_revision("%")
        end,
        desc = "Diff file against commit",
      },
      {
        "<leader>hC",
        diff_repo_revision,
        desc = "Diff repo against commit",
      },
    }
  end
}
