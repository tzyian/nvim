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
nmap("gl", "$", "End of line")
nmap("gh", "^", "Start of line")


-- Show VSCode Which Key
-- set "whichkey.show" to "space" when "editorTextFocus && neovim.mode == 'normal'"
-- vscnmap("<leader>", "whichkey.show", "Show Which Key")

-- VScode Window Navigation
vscnmap("<C-j>", "workbench.action.navigateDown", "Navigate Down")
vscnmap("<C-k>", "workbench.action.navigateUp", "Navigate Up")
vscnmap("<C-h>", "workbench.action.navigateLeft", "Navigate Left")
vscnmap("<C-l>", "workbench.action.navigateRight", "Navigate Right")

vscnmap("<S-l>", "workbench.action.nextEditor", "Next Editor")
vscnmap("<S-h>", "workbench.action.previousEditor", "Previous Editor")

-- Errors
vscnmap("[e", "editor.action.marker.next", "Prev Error")
vscnmap("]e", "editor.action.marker.prev", "Next Error")


-- Folds
vscnmap('zM', 'editor.foldAll', "Fold all")
vscnmap('zR', 'editor.unfoldAll', "Unfold all")
vscnmap('zc', 'editor.fold', "Fold")
vscnmap('zC', 'editor.foldRecursively', "Fold recursively")
vscnmap('zo', 'editor.unfold', "Unfold")
vscnmap('zO', 'editor.unfoldRecursively', "Unfold recursively")
vscnmap('za', 'editor.toggleFold', "Toggle fold")

-- Git
-- vscnmap("<leader>hs", "git.diff.stageHunk", "Stage hunk")
-- vscvmap("<leader>hS", "git.stageSelectedRanges", "Stage range")

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

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("TextFileTypes", { clear = true }),
    pattern = { "markdown", "text", "typst", "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.spell = true
        vim.opt_local.spelllang = {
            -- "en_us",
            "en_gb",
        }
        vim.opt_local.whichwrap:append("hl")

        local punct = { ",", ".", "!", "?", ";", ":" }

        for _, ch in ipairs(punct) do
            vim.keymap.set("i", ch, ch .. "<C-g>u", { noremap = true })
        end
    end,
})


-- For vscode Neovim Ui Modifier
vim.api.nvim_exec2([[
  function! SetCursorLineNrColorInsert(mode)
      if a:mode == "i"
          call VSCodeNotify('nvim-theme.insert')
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
]], {})
