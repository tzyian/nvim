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
vim.o.termguicolors = true

-- Use system clipboard
vim.o.clipboard = "unnamedplus"

-- Line numbers
vim.o.number = true
vim.o.rnu = true
vim.o.statuscolumn = "%s %l %r "
vim.wo.signcolumn = "yes"

-- Remove highlights after searching
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { silent = true })

-- Disable yank on delete
vim.keymap.set("n", "x", '"_x', { noremap = true })
vim.keymap.set("n", "<Del>", '"_x', { noremap = true })

-- Switch buffers quickly
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Buffer [d]elete", silent = true })
vim.keymap.set("n", "[d", ":bp<CR>", { silent = true })
vim.keymap.set("n", "]d", ":bn<CR>", { silent = true })

-- Completion
vim.o.completeopt = "menuone,noselect,noinsert"

-- Diagnostics
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>qq", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "<leader>qh", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "<leader>ql", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Escape terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("t", "<C-w>j", "<C-\\><C-n><C-w>j", { silent = true })
vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-w>k", { silent = true })
vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l", { silent = true })
vim.keymap.set("t", "<C-w>q", "<C-\\><C-n><C-w>q", { silent = true })

-- Comment remaps (not working)
-- vim.keymap.set("n", "<c-_>", "gcc", { desc = "Comment line", silent = true })
-- vim.keymap.set("v", "<c-_>", "gc", { desc = "Comment line", silent = true })

-- Open terminal
vim.keymap.set("n", "<leader>t", ":vsplit<CR>:term<CR>a", { silent = true, desc = "Open [t]erminal" })
vim.keymap.set("n", "<leader>T", ":sp<CR>:term<CR>a", { silent = true, desc = "Open [T]erminal" })

-- Highlight yanked text
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
