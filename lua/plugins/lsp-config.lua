return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim",       opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
    config = function()
      local servers = {
        jdtls = {
          filetypes = { "java" },
        },
        clangd = {
          cmd = {
            "clangd",
            "--offset-encoding=utf-16",
          },
        },
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- tsserver = {},
        -- html = { filetypes = { 'html', 'twig', 'hbs'} },

        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      }

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          })
        end,
      })

      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show [K]ind" })
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "[G]o [D]efinition" })
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "[G]o [R]eferences" })
      vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "[G]o [I]mplementation" })

      vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "[G]o [T]ype Definition" })

      vim.keymap.set("n", "<leader>cds", vim.lsp.buf.document_symbol, { desc = "[C]ode [D]ocument [S]ymbols" })

      vim.keymap.set("n", "<leader>gs", vim.lsp.buf.signature_help, { desc = "[G]o [S]ignature Help" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
    end,
  },
}
