return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    event = "BufEnter",
    lazy = "false",
    keys = {
      -- Files
      { "<leader>ff",  function() Snacks.picker.smart() end,                                   desc = "Find Files" },
      { "<leader>bb",  function() Snacks.picker.buffers() end,                                 desc = "Buffers browse" },
      { "<leader>fc",  function() Snacks.picker.smart({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config" },

      -- Grep
      { "<leader>fg",  function() require("plugins.navi.multigrep.multigrep").live_grep() end, desc = "Find by Grep" },
      { "<leader>/",   function() Snacks.picker.lines() end,                                   desc = "Search Buffer Lines" },

      -- Git
      { "<leader>fhh", function() Snacks.picker.git_log() end,                                 desc = "Git log" },
      { "<leader>fhl", function() Snacks.picker.git_log_line() end,                            desc = "Git log lines" },
      { "<leader>fhf", function() Snacks.picker.git_log_file() end,                            desc = "Git log file" },

      -- History
      { "<leader>f:",  function() Snacks.picker.command_history() end,                         desc = "Find Command History" },
      { "<leader>f/",  function() Snacks.picker.search_history() end,                          desc = "Find Search History" },
      { "<leader>fj",  function() Snacks.picker.jumps() end,                                   desc = "Find Jumps" },

      -- Misc
      { "<leader>fp",  function() Snacks.picker.projects() end,                                desc = "Projects" },
      { "<leader>fy",  function() Snacks.picker.yanky() end,                                   desc = "Yanky" },

      { "<leader>ft",  function() Snacks.picker.todo_comments() end,                           desc = "Find Todo" },
      { "<leader>fd",  function() Snacks.picker.diagnostics() end,                             desc = "Find Diagnostics" },
      { "<leader>fq",  function() Snacks.picker.qflist() end,                                  desc = "Find quickfix" },
      { "<leader>fm",  function() Snacks.picker.marks() end,                                   desc = "Find marks" },
      { "<leader>fr",  function() Snacks.picker.resume() end,                                  desc = "Find Resume" },
      { "<leader>fx",  function() Snacks.picker() end,                                         desc = "Find Select Picker" },
    },
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false, },
      picker = {
        enabled = true,
        matcher = { frecency = true },
        win = {
          input = {
            keys = {
              ["<Tab>"] = { "list_down", mode = { "i", "n" } },
              ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
            },
          },
        },
      },
      notifier = { enabled = false },
      quickfile = { enabled = true },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
      styles = {
        input = {
          relative = "cursor",
          row = -3,
          col = 0,
        }
      }
    },
    config = function(_, opts)
      require("snacks").setup(opts)

      local lsp_picker_keys = {
        { "gr",         Snacks.picker.lsp_references,        "Go References" },
        { "<leader>gr", Snacks.picker.lsp_references,        "Go References" },
        { "gd",         Snacks.picker.lsp_definitions,       "Go Definitions" },
        { "<leader>gd", Snacks.picker.lsp_definitions,       "Go Definitions" },
        { "gD",         Snacks.picker.lsp_type_definitions,  "Go Type Definitions" },
        { "<leader>gD", Snacks.picker.lsp_type_definitions,  "Go Type Definitions" },
        { "gi",         Snacks.picker.lsp_implementations,   "Go Implementations" },
        { "<leader>gi", Snacks.picker.lsp_implementations,   "Go Implementations" },
        { "<leader>gn", Snacks.picker.lsp_incoming_calls,    "Find Incoming" },
        { "<leader>gg", Snacks.picker.lsp_outgoing_calls,    "Find Outgoing" },
        { "<leader>fs", Snacks.picker.lsp_symbols,           "Find Document Symbols" },
        { "<leader>fS", Snacks.picker.lsp_workspace_symbols, "Workspace Symbols" },
      }

      for _, key in ipairs(lsp_picker_keys) do
        vim.keymap.set("n", key[1], key[2], {
          desc = key[3],
          silent = true,
        })
      end
    end,
  },
}
