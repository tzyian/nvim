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
vim.o.breakindent = true
-- vim.o.softtabstop = 2

vim.synmaxcol = 300 -- 300 cols syntax highlighting limit

vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.conceallevel = 1

-- Ask if want to save changes before exiting
vim.o.confirm = true

-- Sync system keyboard
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

if vim.fn.has("wsl") == 1 then
	-- Makes wsl nvim start up faster by not searching for clipboard provider
	-- Also see https://neovim.io/doc/user/provider.html#clipboard-wsl
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

	-- vim.g.clipboard = {
	-- 	name = "WslClipboard",
	-- 	copy = {
	-- 		["+"] = "clip.exe",
	-- 		["*"] = "clip.exe",
	-- 	},
	-- 	paste = {
	-- 		["+"] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
	-- 		["*"] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
	-- 	},
	-- 	cache_enabled = 0,
	-- }
elseif vim.fn.has("win32") == 1 then
	-- Set shell
	local powershell_options = {
		shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
		shellcmdflag =
		"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
		shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
		shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
		shellquote = "",
		shellxquote = "",
	}

	for option, value in pairs(powershell_options) do
		vim.opt[option] = value
	end
end

-- Allow image.nvim to have ft = "png"
-- Useful for viewing assets pasted using img-clip
vim.filetype.add({
	extension = {
		png = "png",
	},
})

-- Line numbers
vim.o.number = true
vim.o.rnu = false

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
vim.opt.diffopt = "vertical"

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
--------------- Diagnostics -----------------
---------------------------------------------
vim.diagnostic.config {
	update_in_insert = false,
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_text = false, -- Text shows up at the end of the line
	virtual_lines = false, -- Text shows up underneath the line, with virtual lines
}

local jump_ns = vim.api.nvim_create_namespace("diagnostic_jump_display")
local function show_line_diags(bufnr, lnum)
	if vim.diagnostic.config().virtual_lines then return end
	local diags = vim.diagnostic.get(bufnr, { lnum = lnum })
	vim.diagnostic.hide(jump_ns, bufnr)
	if vim.tbl_isempty(diags) then return end
	vim.diagnostic.show(jump_ns, bufnr, diags, {
		virtual_text = false,
		virtual_lines = true,
	})
end

local function on_jump(diagnostic, bufnr)
	if diagnostic then
		show_line_diags(bufnr, diagnostic.lnum)
	end
end

vim.api.nvim_create_autocmd("CursorMoved", {
	callback = function(args)
		vim.diagnostic.hide(jump_ns, args.buf)
	end,
})



---------------------------------------------
-------------------- Yank -------------------
---------------------------------------------

-- Keep the cursor position when yanking
local cursorPreYank

vim.keymap.set({ "n", "x" }, "y", function()
	cursorPreYank = vim.api.nvim_win_get_cursor(0)
	return "y"
end, { expr = true })

vim.keymap.set("n", "Y", function()
	cursorPreYank = vim.api.nvim_win_get_cursor(0)
	-- yg_ doesn't yank trailing whitespace/newlines
	return "yg_"
end, { expr = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		if vim.v.event.operator == "y" and cursorPreYank then
			vim.api.nvim_win_set_cursor(0, cursorPreYank)
		end
	end,
})

---------------------------------------------
---------------- Autocorrect ----------------
---------------------------------------------
-- Autocorrect last error in paragraph
local function correct_last_error()
	local mode = vim.api.nvim_get_mode().mode
	local cursor = vim.api.nvim_win_get_cursor(0)
	local current_line = cursor[1]
	local para_start = vim.fn.line("'{")

	vim.cmd('normal! [s')
	local error_pos = vim.api.nvim_win_get_cursor(0)

	if error_pos[1] >= para_start and error_pos[1] <= current_line then
		vim.cmd('normal! 1z=')
		vim.api.nvim_win_set_cursor(0, cursor)
	else
		vim.api.nvim_win_set_cursor(0, cursor)
	end

	if mode:sub(1, 1) == 'i' then
		vim.cmd('startinsert')
	end
end


---------------------------------------------
------------------ Keymaps ------------------
---------------------------------------------

nmap("gh", "^", "Move to beginning of line")
nmap("gl", "$", "Move to end of line")

-- H and L defaults to first and last line in viewport
-- textobjects only maps for a-i, not operator-pending
map("o", "H", "^", "End of line")
map("o", "L", "$", "Start of line")

-- In insert mode, <C-x><C-s> goes to last error and gives suggestion list
-- imap("<M-s>", "<c-g>u<Esc>[s1z=`]a<c-g>u", "Fix last typo in buffer")
imap("<M-s>", correct_last_error, "Autocorrect last typo in paragraph")
nmap("<M-s>", correct_last_error, "Autocorrect last typo in paragraph")

-- Remove highlights after searching
nmap("<Esc>", "<cmd>nohlsearch<CR>", "Remove highlights after searching")

-- Disable yank on delete
nmap("x", '"_x', "Disable yank on delete")
nmap("<Del>", '"_x', "Disable yank on delete")
vmap("p", '"_dP', "Paste")

-- Diagnostics
nmap("<leader>e", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
	show_line_diags(bufnr, lnum)
end, "Show diagnostic")

nmap("<leader>E", vim.diagnostic.open_float, "Open floating diagnostic message")
nmap("]d", function()
	vim.diagnostic.jump({ count = 1, on_jump = on_jump })
end, "Next diagnostic")
nmap("[d", function()
	vim.diagnostic.jump({ count = -1, on_jump = on_jump })
end, "Previous diagnostic")
nmap("<leader>cq", function()
	vim.diagnostic.config {
		virtual_lines = not vim.diagnostic.config().virtual_lines,
	}
end, "Toggle display errors")

-- nmap("<leader>qq", vim.diagnostic.setloclist, "Open diagnostics loclist ")

imap("<C-k>", vim.lsp.buf.signature_help, "Toggle signature")

-- Delete word in front
imap("<C-e>", "<C-o>de", "Delete word")

-- Remap for dealing with word wrap
nmap("k", "v:count == 0 ? 'gk' : 'k'", "Move up (respecting word wrap)", { expr = true })
nmap("j", "v:count == 0 ? 'gj' : 'j'", "Move down (respecting word wrap)", { expr = true })

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
-- nmap("<Tab>", "gt", "Next tab")
-- nmap("<S-Tab>", "gT", "Previous tab")

-- Comment remaps (not working)
-- vim.keymap.set("n", "<c-_>", "gcc", { desc = "Comment line", silent = true })
-- vim.keymap.set("v", "<c-_>", "gc", { desc = "Comment line", silent = true })

-- For saving convenience
nmap("<leader>w", "<cmd>w<CR>", "Save")

-- Misc Config
nmap("<leader>ml", "<cmd>Lazy<CR>", "Lazy")
nmap("<leader>mm", "<cmd>Mason<CR>", "Mason")
nmap("<leader>mi", "<cmd>checkhealth vim.lsp<CR>", "LspInfo")
nmap("<leader>mn", "<cmd>NullLsInfo<CR>", "NullLsInfo")
