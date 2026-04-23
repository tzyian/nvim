local bufnr = vim.api.nvim_get_current_buf()

nmap("K", function() vim.cmd.RustLsp({ 'hover', 'actions' }) end, "Rust Hover Actions", { buffer = bufnr })
nmap("<leader>ca", function() vim.cmd.RustLsp('codeAction') end, "Rust Code Action", { buffer = bufnr })
nmap("<leader>ce", function() vim.cmd.RustLsp('explainError') end, "Rust Explain Error", { buffer = bufnr })
nmap("<leader>ge", function() vim.cmd.RustLsp('relatedDiagnostics') end, "Rust related diagnostics", { buffer = bufnr })
nmap("ge", function() vim.cmd.RustLsp('relatedDiagnostics') end, "Rust related diagnostics", { buffer = bufnr })
nmap("<leader>rr", function() vim.cmd.RustLsp('runnables') end, "Rust Run", { buffer = bufnr })

nmap("<leader><Up>", function() vim.cmd.RustLsp { 'moveItem', 'up' } end, "Rust Move Item Down", { buffer = bufnr })
nmap("<leader><Down>", function() vim.cmd.RustLsp { 'moveItem', 'down' } end, "Rust Move Item Up", { buffer = bufnr })

nmap("<leader>J", function() vim.cmd.RustLsp('joinLines') end, "Rust Join Lines", { buffer = bufnr })
