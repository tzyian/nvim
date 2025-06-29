-- Set before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 2

-- Use system clipboard
vim.o.clipboard = "unnamedplus"

-- Case insensitive search unless capital letters are used or \C
vim.o.ignorecase = true
vim.o.smartcase = true

-- Search options
vim.o.incsearch = true
vim.o.inccommand = "nosplit"

local vscode = require('vscode')

local function nmap(key, command, desc)
    vim.keymap.set("n", key, command, { desc = desc, noremap = true, silent = true })
end

local function vscnmap(key, option, desc)
    vim.keymap.set("n", key, function() vscode.call(option) end, { desc = desc, silent = true })
end

local function vscvmap(key, option, desc)
    vim.keymap.set("v", key, function() vscode.call(option) end, { desc = desc, silent = true })
end


-- Disable yank on delete
nmap("x", '"_x', "Disable yank on delete")
nmap("<Del>", '"_x', "Disable yank on delete")

nmap("<Esc>", "<cmd>nohlsearch<CR>", "Remove highlights after searching")
-- nmap("<leader>w", "<cmd>w<CR>", "Save")


-- Better keymaps
-- vim.keymap.set({ "n", "v", "o" }, "H", "^", { noremap = true })
-- vim.keymap.set({ "n", "v", "o" }, "L", "$", { noremap = true })

-- Show VSCode Which Key
-- set "whichkey.show" to "space" when "editorTextFocus && neovim.mode == 'normal'"
-- vscnmap("<leader>", "whichkey.show", "Show Which Key")

-- Remap for dealing with word wrap
-- nmap("k", "gk", "Move up wrapped line")
-- nmap("j", "gj", "Move down wrapped line")
--
-- VScode Window Navigation
vscnmap("<C-j>", "workbench.action.navigateDown", "Navigate Down")
vscnmap("<C-k>", "workbench.action.navigateUp", "Navigate Up")
vscnmap("<C-h>", "workbench.action.navigateLeft", "Navigate Left")
vscnmap("<C-l>", "workbench.action.navigateRight", "Navigate Right")

vscnmap("<S-l>", "workbench.action.nextEditor", "Next Editor")
vscnmap("<S-h>", "workbench.action.previousEditor", "Previous Editor")

-- Zen Mode
-- vscnmap("<leader>z", "workbench.action.toggleZenMode", "Zen Mode")

-- File Explorer
-- vscnmap("<leader>n", "workbench.view.explorer", "Explorer")

-- Telescope
-- vscnmap("<leader>fg", "workbench.action.findInFiles", "Find Grep")
-- vscnmap("<leader>ff", "workbench.action.quickOpen", "Find File")
-- vscnmap("<leader>gd", "editor.action.revealDefinition", "Go to definition")
-- vscnmap("<leader>gr", "editor.action.goToReferences", "Go to references")
-- vscnmap("<leader>gi", "editor.action.goToImplementation", "Go to implementation")

-- Errors
-- vscnmap("<leader>e", "editor.action.showHover", "Hover")
-- vscnmap("<leader>q", "workbench.actions.view.problems", "Errors")
vscnmap("[e", "editor.action.marker.next", "Prev Error")
vscnmap("]e", "editor.action.marker.prev", "Next Error")

-- Git
-- vscnmap("<leader>hd", "git.openChange", "Diff")
-- vscnmap("<leader>hu", "git.unstageSelectedRanges", "Undo stage range")
-- vscnmap("<leader>hr", "git.revertSelectedRanges", "Revert range")
-- vscnmap("<leader>hp", "editor.action.dirtydiff.next", "Next Diff")
-- vscnmap("<leader>hm", "editor.action.dirtydiff.previous", "Prev Diff")
-- vscnmap("<leader>hs", "git.diff.stageHunk", "Stage hunk")
-- vscvmap("<leader>hS", "git.stageSelectedRanges", "Stage range")

-- Code
-- vscnmap("<leader>cr", "editor.action.rename", "Rename")
-- vscnmap("<leader>cf", "editor.action.formatDocument", "Format")

local function mapMove(key, direction)
    vim.keymap.set('n', key, function()
        local count = vim.v.count
        local v = 1
        local style = 'wrappedLine'
        if count > 0 then
            v = count
            style = 'line'
        end
        vscode.action('cursorMove', {
            args = {
                to = direction,
                by = style,
                value = v
            }
        })
    end)
end

mapMove('k', 'up')
mapMove('j', 'down')


vscnmap('zM', 'editor.foldAll', "Fold all")
vscnmap('zR', 'editor.unfoldAll', "Unfold all")
vscnmap('zc', 'editor.fold', "Fold")
vscnmap('zC', 'editor.foldRecursively', "Fold recursively")
vscnmap('zo', 'editor.unfold', "Unfold")
vscnmap('zO', 'editor.unfoldRecursively', "Unfold recursively")
vscnmap('za', 'editor.toggleFold', "Toggle fold")



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
