return {
  'gelguy/wilder.nvim',
  event = "VeryLazy",
  config = function()
    require("wilder").setup()
  end,
}
