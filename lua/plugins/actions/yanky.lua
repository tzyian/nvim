return {
  "gbprod/yanky.nvim",
  lazy = true,
  keys = {
    { "[y",         "<Plug>(YankyPreviousEntry)" },
    { "]y",         "<Plug>(YankyNextEntry)" },
    { "<leader>fy", "<cmd>YankyRingHistory<cr>", desc = "YankyRingHistory" },
  },
  opts = {
    highlight = {
      -- Disabled to use in vim-options.lua
      on_put = false,
      on_yank = false,
      timer = 100,
    },
  },
}
