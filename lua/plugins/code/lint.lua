return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "InsertLeave" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      go = { "golangcilint" },
      c = { "cppcheck" },
      cpp = { "cppcheck" },
      elixir = { "credo" },
      sh = { "shellcheck" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("nvim_lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        -- Only run linter if file is modified or on save/enter, and file exists
        if vim.bo.buftype == "" and vim.api.nvim_buf_get_name(0) ~= "" then
          lint.try_lint()
        end
      end,
    })
  end,
}
