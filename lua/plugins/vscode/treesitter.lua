return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
    config = function()
      local ts = require("nvim-treesitter")

      local ensureInstalled = { 'bash', 'lua', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', "python" }

      ts.install(ensureInstalled)

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then return end

          disabled = { "latex", "csv" }
          if vim.tbl_contains(disabled, language) then return end

          local available = vim.list_contains(ts.get_available(), language)
          if not available then return end

          ts.install({ language })

          -- check if parser exists and load it
          if not vim.treesitter.language.add(language) then return end
          -- enables syntax highlighting and other treesitter features


          vim.treesitter.start(buf, language)

          -- enables treesitter based folds
          -- for more info on folds see `:help folds`
          -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          -- vim.wo.foldmethod = 'expr'

          -- enables treesitter based indentation
          -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
