return {
  "MagicDuck/grug-far.nvim",
  opts = { headerMaxWidth = 80 },
  cmd = "GrugFar",
  keys = {
    {
      "<leader>cs",
      "<cmd>GrugFar<CR>",
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
  },
}
