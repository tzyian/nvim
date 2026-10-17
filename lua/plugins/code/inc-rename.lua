return {
  {
    "smjonas/inc-rename.nvim",
    lazy = true,
    opts = {
      input_buffer_type = "dressing",
    },
    keys = {
      { "<leader>cr", ":IncRename ", desc = "Incremental Rename" },
    }
  }
}
