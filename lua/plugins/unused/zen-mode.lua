return {
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>pz", "<cmd>ZenMode<cr>", desc = "ZenMode" }
    },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
    --WhichKey
    --  {
    -- 	"<leader>pz",
    -- 	"<cmd>ZenMode<CR>",
    -- 	desc = "Toggle Zen Mode",
    -- 	icon = function()
    -- 		local active = package.loaded["zen-mode.view"] and require("zen-mode.view").is_open()
    -- 		return active and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
    -- 	end,
    -- }
  }

}
