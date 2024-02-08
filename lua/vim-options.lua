vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.autoindent = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.smarttab = true
vim.o.shiftwidth = 2
vim.o.timeoutlen = 300

vim.termguicolors = true

-- Use system clipboard
vim.o.clipboard = "unnamedplus"

-- Line numbers
vim.o.number = true
vim.o.rnu = true
vim.o.statuscolumn = "%s %l %r "
vim.wo.signcolumn = "yes"

-- vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Disable yank on delete
vim.keymap.set("n", "x", '"_x', { noremap = true })
vim.keymap.set("n", "<Del>", '"_x', { noremap = true })

-- Completion
vim.o.completeopt = "menuone,noselect,noinsert"

-- Diagnostics
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Escape terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("t", "<C-w>j", "<C-\\><C-n><C-w>j", { silent = true })
vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-w>k", { silent = true })
vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l", { silent = true })

-- Open terminal
vim.keymap.set("n", "<leader>t", ":vsplit<CR>:term<CR>a", { silent = true, desc = "Open [t]erminal" })

-- Etc
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
