local bufnr = vim.api.nvim_get_current_buf()

map("<leader>ca", function() vim.cmd.RustLsp('codeAction') end, "Rust Code Action")

map("<leader>E", function() vim.cmd.RustLsp('explainError') end, "Rust Explain Error")

map("K", function() vim.cmd.RustLsp({ 'hover', 'actions' }) end, "Rust Hover Actions")

map("<leader>rr", function() vim.cmd.RustLsp('run') end, "Rust Run")

-- map("<M-Down>", function() vim.cmd.RustLsp('moveItemDown') end, "Rust Move Item Down")
--
-- map("<M-Up>", function() vim.cmd.RustLsp('moveItemUp') end, "Rust Move Item Up")
