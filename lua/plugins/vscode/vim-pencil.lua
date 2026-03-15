return {
  {
    "preservim/vim-pencil",
    ft = { "markdown", "text", "typst" },
    config = function()
      vim.g["wrapModeDefault"] = "soft"
      vim.cmd("PencilSoft")
    end,
  },
}
