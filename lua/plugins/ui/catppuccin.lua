return {
  "catppuccin/nvim",
  -- lazy = false,
  -- event = "BufWinEnter",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      lsp_styles = {
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
    })

    vim.cmd.colorscheme("catppuccin-nvim")
    vim.cmd([[
        hi! FlashLabel guifg=black guibg=orange
        " the text selected when typing / or shift tab
        " hi! FlashCurrent guifg=black guibg=#FF00FF
        " not sure why FlashCursor is not working
        " hi! FlashCursor guifg=red guibg=blue
      ]])
  end,
}
