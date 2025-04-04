-- ~/.config/nvim/after/ftplugin/haskell.lua
local ht = require('haskell-tools')
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }
-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set('n', '<space>ls', ht.hoogle.hoogle_signature,
  { desc = "Hoogle signature" }, opts)
-- Evaluate all code snippets
vim.keymap.set('n', '<space>la', ht.lsp.buf_eval_all, { desc = "Evaluate all" }, opts)
-- Toggle a GHCi repl for the current package
vim.keymap.set('n', '<leader>lr', ht.repl.toggle, { desc = "Toggle repl" }, opts)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set('n', '<leader>lf', function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, { desc = "Toggle repl for buffer" }, opts)
vim.keymap.set('n', '<leader>lq', ht.repl.quit, { desc = "Quit repl" }, opts)
