return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- null_ls.builtins.diagnostics.codespell.with({
        --   filetypes = { "markdown", "typst" },
        -- }),
        null_ls.builtins.completion.spell.with({
          filetypes = { "markdown", "typst" },
        }),

        ------------ Shell
        -- null_ls.builtins.diagnostics.gitleaks,

        ------------ Elixir
        null_ls.builtins.diagnostics.credo,

        ------------ Go
        -- null_ls.builtins.code_actions.gomodifytags,
        null_ls.builtins.diagnostics.golangci_lint,

        ------------ Python

        ------------ C/C++
        null_ls.builtins.diagnostics.cppcheck,
        -- null_ls.builtins.diagnostics.cmake_lint,

        ------------ JS
        -- null_ls.builtins.diagnostics.spectral,

        ------------ SQL
        -- null_ls.builtins.diagnostics.sqlfluff.with({
        -- 	extra_args = { "--dialect", "postgres" }, -- change to your dialect
        -- }),

        ------------ Java
        -- null_ls.builtins.diagnostics.checkstyle.with({
        -- extra_args = { "-c", "/google_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules
        -- extra_args = { "-c", "/sun_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules
        -- }),
        -- null_ls.builtins.diagnostics.pmd.with({
        --   extra_args = {
        --     "--rulesets",
        --     "category/java/bestpractices.xml,category/jsp/bestpractices.xml", -- or path to self-written ruleset
        --   },
        -- }),
        --
        --
        ------------ Deployment
        -- null_ls.builtins.diagnostics.hadolint
        -- null_ls.builtins.diagnostics.kube_linter
        -- null_ls.builtins.diagnostics.terraform_validate
        -- null_ls.builtins.diagnostics.tfsec

        ------------ Others
        -- null_ls.builtins.diagnostics.markdownlint,
        -- null_ls.builtins.code_actions.refactoring,
        -- null_ls.builtins.diagnostics.semgrep,
      },
    })
  end,
}
