return {
  "MagicDuck/grug-far.nvim",
  opts = {
    headerMaxWidth = 80,
    engines = {
      ripgrep = {
        extraArgs = '--smart-case -C 1',
        placeholders = {
          search = 'e.g. foo_([a-z0-9]*)   fun\\(',
          replacement = 'e.g. ${1}_foo   $$MY_ENV_VAR ',
          filesFilter = '(newline delimited) e.g. !*.out   *.{css,js}   **/docs/*.md',
          flags = 'e.g. -uuu, -C 3, -F (fixed string), -s (sensitive)',
          paths = '(space-delimited)',

        }

      }
    }

  },
  cmd = "GrugFar",
  keys = {
    {
      "<leader>cs",
      "<cmd>GrugFar<CR>",
      desc = "Search and Replace",
    },
  },
}
