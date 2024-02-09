return {
  "folke/which-key.nvim",
  opts = function()
    -- document existing key chains
    require("which-key").register({
      ["<leader>f"] = { name = "[F]ind", _ = "which_key_ignore" },
      ["<leader>g"] = { name = "[G]o", _ = "which_key_ignore" },
      ["<leader>b"] = { name = "[B]uffer", _ = "which_key_ignore" },
      ["<leader>d"] = { name = "[D]ebug", _ = "which_key_ignore" },
      ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
      ["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
      ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
      ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
      ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
    })

    -- register which-key VISUAL mode
    -- required for visual <leader>hs (hunk stage) to work
    require("which-key").register({
      ["<leader>"] = { name = "VISUAL <leader>" },
      ["<leader>h"] = { "Git [H]unk" },
    }, { mode = "v" })
  end,
}
