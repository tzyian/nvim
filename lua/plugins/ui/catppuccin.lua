return {
  "catppuccin/nvim",
  -- lazy = false,
  -- event = "BufWinEnter",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      -- custom_highlights = function(colors)
      --   return {
      --     FlashLabel = { guifg = colors.black, guibg = colors.orange },
      --   }
      -- end,

      integrations = {
        -- flash = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
    })

    vim.cmd.colorscheme("catppuccin")
    vim.cmd([[
        hi! FlashLabel guifg=black guibg=orange
      ]])
  end,
}
