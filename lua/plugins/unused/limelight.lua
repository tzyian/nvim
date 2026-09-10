return {
  {
    "junegunn/limelight.vim",
    ft = { "markdown", "text", "typst" },
    cmd = "Limelight",
    keys = {
      { "<leader>pl", "<cmd>Limelight!!<cr>", desc = "Toggle Limelight" }
    },
    -- WhichKey
    --  {
    -- 	"<leader>pl",
    -- 	"<cmd>Limelight!!<CR>",
    -- 	desc = "Toggle Limelight",
    -- 	icon = function()
    -- 		local active = vim.fn.exists("#limelight") == 1
    -- 		return active and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
    -- 	end,
    -- }
  }
}
