return {
  "catppuccin/nvim",
  -- lazy = false,
  -- event = "BufWinEnter",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("catppuccin")

    vim.cmd([[
        hi! FlashLabel guifg=black guibg=orange
      ]])
  end,
}
