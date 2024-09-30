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
-- vim.o.softtabstop = 2

vim.o.termguicolors = true
vim.o.background = "dark"

-- Sync system keyboard
vim.o.clipboard = "unnamedplus"

if vim.fn.has("wsl") == 1 then
	-- For nvim python provider
	-- Here since this won't be used anywhere else
	vim.g.python3_host_prog = "~/.pyenv/versions/pynvim/bin/python"

	-- Makes wsl nvim faster by not searching for clipboard provider
	vim.g.clipboard = {
		name = "win32yank",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = true,
	}
elseif vim.fn.has("win32") == 1 then
	-- Set shell
	local powershell_options = {
		shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
		shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
		shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
		shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
		shellquote = "",
		shellxquote = "",
	}

	for option, value in pairs(powershell_options) do
		vim.opt[option] = value
	end
end

-- Line numbers
vim.o.number = true
vim.o.rnu = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 2

-- Decrease update time
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
vim.opt.inccommand = "split"

-- Gutter
-- vim.o.statuscolumn = "%s %l %r "
vim.wo.signcolumn = "auto:1"
vim.wo.foldcolumn = "auto:1"

-- Completion
vim.o.completeopt = "menuone,noselect,noinsert"

---------------------------------------------
------------------ Keymaps ------------------
---------------------------------------------

local function nmap(key, option, desc)
	vim.keymap.set("n", key, option, { desc = desc })
end

local function tmap(key, option, desc)
	vim.keymap.set("t", key, option, { desc = desc })
end

-- Better cursor movement
-- vim.keymap.set({ "n", "o", "v" }, "H", "^", { silent = true })
-- vim.keymap.set({ "n", "o", "v" }, "L", "$", { silent = true })

-- Remove highlights after searching
nmap("<Esc>", "<cmd>nohlsearch<CR>", "Remove highlights after searching")

-- Disable yank on delete
nmap("x", '"_x', "Disable yank on delete")
nmap("<Del>", '"_x', "Disable yank on delete")

-- -- Switch buffers quickly
-- nmap("<leader>bd", "<cmd>bdelete<CR>", "Buffer delete")
-- nmap("[b", "<cmd>bp<CR>", "Previous buffer")
-- nmap("]b", "<cmd>bn<CR>", "Next buffer")
-- nmap("<leader>b[", "<cmd>bp<CR>", "Previous buffer")
-- nmap("<leader>b]", "<cmd>bp<CR>", "Next buffer")

-- Diagnostics
nmap("<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
nmap("<leader>ql", vim.diagnostic.setloclist, "Open diagnostics list")
nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic message")

vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { silent = true, noremap = true, desc = "toggle signature" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Open terminal
nmap("<leader>tt", "<cmd>vsplit<CR><cmd>term<CR>a", "Open terminal")
nmap("<leader>tT", "<cmd>sp<CR><cmd>term<CR>a", "Open Terminal")

-- Escape terminal mode
tmap("<Esc>", "<C-\\><C-n>", "Escape terminal mode")
tmap("<C-w>h", "<C-\\><C-n><C-w>h", "Move to left window")
tmap("<C-w>j", "<C-\\><C-n><C-w>j", "Move to window below")
tmap("<C-w>k", "<C-\\><C-n><C-w>k", "Move to window above")
tmap("<C-w>l", "<C-\\><C-n><C-w>l", "Move to right window")
tmap("<C-w>q", "<C-\\><C-n><C-w>q", "Close window")

-- Switch tabs
nmap("<C-n>", "gt", "Next tab")
nmap("<C-p>", "gT", "Previous tab")
nmap("<Tab>", "gt", "Next tab")
nmap("<S-Tab>", "gT", "Previous tab")

-- Comment remaps (not working)
-- vim.keymap.set("n", "<c-_>", "gcc", { desc = "Comment line", silent = true })
-- vim.keymap.set("v", "<c-_>", "gc", { desc = "Comment line", silent = true })

-- For saving convenience
nmap("<leader>w", "<cmd>w<CR>", "Save")

-- Misc Config
nmap("<leader>ml", "<cmd>Lazy<CR>", "Lazy")
nmap("<leader>mm", "<cmd>Mason<CR>", "Mason")
nmap("<leader>mi", "<cmd>LspInfo<CR>", "LspInfo")
nmap(
	"<leader>mc",
	"<cmd>tabnew ~/.config/nvim/lua/vim-options.lua<CR> <cmd>cd ~/.config/nvim/<CR> <cmd>NvimTreeOpen ~/.config/nvim<CR>",
	"Edit config"
)
