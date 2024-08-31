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

local function vscmap(key, option, desc)
    vim.keymap.set("n", key, "<cmd>call VSCodeNotify('" .. option .. "')<CR>", { desc = desc })
end

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove highlights after searching" })

-- For saving convenience
-- vim.keymap.set("n", "<leader>w", "<Cmd>w<CR>", { desc = "Save" })

-- Better keymaps
-- vim.keymap.set({ "n", "v", "o" }, "H", "^", { noremap = true })
-- vim.keymap.set({ "n", "v", "o" }, "L", "$", { noremap = true })

-- Show VSCode Which Key
-- vim.keymap.set({ "n", "v", "o" }, "<leader>", "<cmd>call VSCodeNotify('whichkey.show')<CR>", { noremap = true })
vscmap("<leader>", "whichkey.show", "Show Which Key")

-- Remap for dealing with word wrap
-- vim.keymap.set("n", "k", "gk", { silent = true, noremap = true })
-- vim.keymap.set("n", "j", "gj", { silent = true, noremap = true })

-- VScode Window Navigation
vscmap("<C-j>", "workbench.action.navigateDown", "Navigate Down")
vscmap("<C-k>", "workbench.action.navigateUp", "Navigate Up")
vscmap("<C-h>", "workbench.action.navigateLeft", "Navigate Left")
vscmap("<C-l>", "workbench.action.navigateRight", "Navigate Right")

vscmap("<S-l>", "workbench.action.nextEditor", "Next Editor")
vscmap("<S-h>", "workbench.action.previousEditor", "Previous Editor")

-- Zen Mode
-- vscmap("<leader>z", "workbench.action.toggleZenMode", "Zen Mode")

-- File Explorer
-- vscmap("<leader>n", "workbench.view.explorer", "Explorer")

-- Telescope
-- vscmap("<leader>fg", "workbench.action.findInFiles", "Find Grep")
-- vscmap("<leader>ff", "workbench.action.quickOpen", "Find File")
-- vscmap("<leader>gd", "editor.action.revealDefinition", "Go to definition")
-- vscmap("<leader>gr", "editor.action.goToReferences", "Go to references")
-- vscmap("<leader>gi", "editor.action.goToImplementation", "Go to implementation")

-- Errors
-- vscmap("<leader>e", "editor.action.showHover", "Hover")
-- vscmap("<leader>q", "workbench.actions.view.problems", "Errors")
vscmap("[e", "editor.action.marker.next", "Prev Error")
vscmap("]e", "editor.action.marker.prev", "Next Error")

-- Git
-- vscmap("<leader>hd", "git.openChange", "Diff")
-- vscmap("<leader>hu", "git.unstageSelectedRanges", "Undo stage range")
-- vscmap("<leader>hs", "git.diff.stageHunk", "Stage hunk")
-- vscmap("<leader>hs", "git.stageSelectedRanges", "Stage range")
-- vscmap("<leader>hr", "git.revertSelectedRanges", "Revert range")
-- vscmap("<leader>hp", "editor.action.dirtydiff.next", "Next Diff")
-- vscmap("<leader>hm", "editor.action.dirtydiff.previous", "Prev Diff")
vim.keymap.set("n", "]h", "editor.action.dirtydiff.next", { desc = "Next diff" })
vim.keymap.set("n", "[h", "editor.action.dirtydiff.previous", { desc = "Previous diff" })

-- Code
-- vscmap("<leader>cr", "editor.action.rename", "Rename")
-- vscmap("<leader>cf", "editor.action.formatDocument", "Format")

--[[
-- Useful VSCode Shortcuts
-- -----------------------
-- Ctrl+B - Toggle Sidebar
-- Ctrl+Q - Cycle Sidebar
-- Ctrl+H - Replace
-- Alt+Shift+O - ISort
-- Ctrl+Alt+Up/Down - Multi Cursor
-- Ctrl+Alt+Left/Right - Move editor group
-- Alt+Shift+Down - Up/Duplicate Line
--
-- VSCode Keymaps
-- --------------
-- "Which Key: Show Menu" when "editorTextFocus && neovim.mode == 'normal'"
--]]

-- Set Flash.nvim  highlight label
vim.cmd([[
    hi! FlashLabel guifg=#b0e8b0  guibg=#660033 cterm=bold gui=bold
  ]])

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
        autocmd ModeChanged *:R* call VSCodeNotify('nvim-theme.replace')
        autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
        autocmd InsertLeave * call VSCodeNotify('nvim-theme.normal')
        autocmd CursorHold * call VSCodeNotify('nvim-theme.normal')
        autocmd ModeChanged [vV\x16]*:* call VSCodeNotify('nvim-theme.normal')
    augroup END
]],
    false
)
