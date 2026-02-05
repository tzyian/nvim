return {
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  version = '1.*',
  config = function(_, opts)
    require('typst-preview').setup(opts)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'typst',
      callback = function()
        vim.keymap.set('n', '<leader>pt', '<cmd>TypstPreview<cr>', {
          buffer = true,
          desc = 'Preview Typst Document'
        })
      end,
    })
  end,
}
