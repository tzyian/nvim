-- Set before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Indent settings
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.smarttab = true
vim.o.shiftwidth = 2

vim.o.termguicolors = true

-- Use system clipboard
vim.o.clipboard = "unnamedplus"

-- Line numbers
vim.o.number = true
vim.o.rnu = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 2

-- Desrease update time
vim.o.timeoutlen = 300
vim.o.updatetime = 250

-- Save undo history
vim.opt.undofile = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Case insensitive search unless capital letters are used or \C
vim.o.ignorecase = true
vim.o.smartcase = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Gutter
-- vim.o.statuscolumn = "%s %l %r "
vim.wo.signcolumn = "auto:1"
vim.wo.foldcolumn = "auto:1"

-- Remove highlights after searching
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

-- Disable yank on delete
vim.keymap.set("n", "x", '"_x', { noremap = true })
vim.keymap.set("n", "<Del>", '"_x', { noremap = true })

-- Switch buffers quickly
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Buffer [d]elete", silent = true })
vim.keymap.set("n", "[b", ":bp<CR>", { silent = true, desc = "Previous [b]uffer" })
vim.keymap.set("n", "]b", ":bn<CR>", { silent = true, desc = "Next [b]uffer" })
vim.keymap.set("n", "<leader>bp", ":bp<CR>", { silent = true, desc = "Previous [b]uffer" })
vim.keymap.set("n", "<leader>bn", ":bp<CR>", { silent = true, desc = "Next [b]uffer" })

-- Completion
vim.o.completeopt = "menuone,noselect,noinsert"

-- Diagnostics
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>ql", vim.diagnostic.setloclist, { desc = "Open diagnostics [l]ist" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Open terminal
vim.keymap.set("n", "<leader>t", ":vsplit<CR>:term<CR>a", { silent = true, desc = "Open [t]erminal" })
vim.keymap.set("n", "<leader>T", ":sp<CR>:term<CR>a", { silent = true, desc = "Open [T]erminal" })

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

-- Misc Config
vim.keymap.set("n", "<leader>ml", ":Lazy<CR>", { desc = ":Lazy" })
vim.keymap.set("n", "<leader>mm", ":Mason<CR>", { desc = ":Mason" })
vim.keymap.set("n", "<leader>mi", ":LspInfo<CR>", { desc = "LspInfo" })
vim.keymap.set("n", "<leader>mc", ":tabnew<CR>:cd ~/.config/nvim<CR>:NvimTreeOpen<CR>",
	{ noremap = true, desc = "Edit config" })

-- Highlight yanked text
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
