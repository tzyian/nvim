local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }

vim.keymap.set('n', '<space>cb', function()
  local save_pos = vim.fn.getpos('.')

  -- Substitute [ with { and ] with } on the current line
  -- If you want this to apply globally or to a visual selection, the pattern can be tweaked.
  vim.cmd([[s/\[/{/g]])
  vim.cmd([[s/\]/}/g]])

  -- Restore cursor position and clear search highlight
  vim.fn.setpos('.', save_pos)
  vim.cmd('noh')
end, { desc = "Square to curly" }, opts)
