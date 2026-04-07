local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("YankHighlight"),
  callback = function()
    vim.hl.on_yank()
  end,
  pattern = "*",
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("LastLocation"),
  callback = function(event)
    local buf = event.buf
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      vim.cmd('normal! g`"zz')
    end
  end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("HelpVerticalSplit"),
  pattern = "help",
  command = "wincmd L",
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
  group    = augroup("NoAutoComment"),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- set undo marker on punctuation in text file types
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("UndoBreakPoints"),
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


vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "checkhealth", },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
