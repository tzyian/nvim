return {
  {
    "junegunn/limelight.vim",
    ft = { "markdown", "text", "typst" },
    cmd = "Limelight",
    keys = {
      {"<leader>pl", "<cmd>Limelight!!<cr>", desc= "Toggle Limelight"}
    },
  },
  {
    "preservim/vim-pencil",
    ft = { "markdown", "text", "typst" },
    config = function()
      vim.g["wrapModeDefault"] = "soft"
      vim.cmd("PencilSoft")
    end,
  },
}