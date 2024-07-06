return {
  "chomosuke/term-edit.nvim",
  lazy = true,
  ft = { "fterm_lazygit", "FTerm" },
  version = "1.*",
  config = function()
    local shell = {
      ["/bin/bash"] = "%$ ",
      ["powershell.exe"] = "> ",
      ["cmd.exe"] = "> ",
    }

    require("term-edit").setup({
      prompt_end = shell[vim.o.shell] or "%$ ",
    })
  end,
}
