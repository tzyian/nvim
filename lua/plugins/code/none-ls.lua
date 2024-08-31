return {
  "nvimtools/none-ls.nvim",
  event = "VeryLazy",
  config = function()
    local null_ls = require("null-ls")

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })

    vim.keymap.set("n", "<leader>ctg", "<cmd>FormatDisable!<CR>", { desc = "Disable format on save (buffer)" })
    vim.keymap.set("n", "<leader>ctG", "<cmd>FormatDisable<CR>", { desc = "Disable format on save globally" })
    vim.keymap.set("n", "<leader>cte", "<cmd>FormatEnable!<CR>", { desc = "Enable format on save (buffer)" })
    vim.keymap.set("n", "<leader>ctE", "<cmd>FormatEnable<CR>", { desc = "Enable format on save globally" })

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,

        null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.rustywind,
        -- null_ls.builtins.diagnostics.eslint_d,

        -- null_ls.builtins.diagnostics.erb_lint,

        -- null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.shellharden,

        -- null_ls.builtins.diagnostics.markdownlint,

        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,

        null_ls.builtins.formatting.yamlfmt,
        null_ls.builtins.diagnostics.yamllint,
        --
        null_ls.builtins.formatting.ocamlformat,

        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.diagnostics.golangci_lint,

        -- null_ls.builtins.formatting.clang_format,
        null_ls.builtins.diagnostics.cppcheck,
      },

      on_attach = function(client, bufnr)
        if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
          return
        end

        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
              -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
              if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
                return
              end
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })

    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode [F]ormat" })
  end,
}
