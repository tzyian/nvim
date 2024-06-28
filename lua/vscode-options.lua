-- Set before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 2

-- Use system clipboard
vim.o.clipboard = "unnamedplus"

-- Disable yank on delete
vim.keymap.set("n", "x", '"_x', { noremap = true })
vim.keymap.set("n", "<Del>", '"_x', { noremap = true })

-- Case insensitive search unless capital letters are used or \C
vim.o.ignorecase = true
vim.o.smartcase = true

-- Search options
vim.o.incsearch = true
vim.o.inccommand = "nosplit"

-- For saving convenience
vim.keymap.set("n", "<leader>w", "<Cmd>w<CR>", { desc = "Save" })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- For vscode Neovim Ui Modifier
vim.api.nvim_exec(
    [[
    " THEME CHANGER
    function! SetCursorLineNrColorInsert(mode)
        " Insert mode: blue
        if a:mode == "i"
            call VSCodeNotify('nvim-theme.insert')

        " Replace mode: red
        elseif a:mode == "r"
            call VSCodeNotify('nvim-theme.replace')
        endif
    endfunction

    augroup CursorLineNrColorSwap
        autocmd!
        autocmd ModeChanged *:[vV\x16]* call VSCodeNotify('nvim-theme.visual')
        autocmd ModeChanged *:[R]* call VSCodeNotify('nvim-theme.replace')
        autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
        autocmd InsertLeave * call VSCodeNotify('nvim-theme.normal')
        autocmd CursorHold * call VSCodeNotify('nvim-theme.normal')
        autocmd ModeChanged [vV\x16]*:* call VSCodeNotify('nvim-theme.normal')
    augroup END
]],
    false
)
