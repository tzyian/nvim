return {
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  version = '1.*',
  opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  keys = {
    { '<leader>pt', '<cmd>TypstPreview<cr>', desc = 'Preview Typst Document' },
  }
}
