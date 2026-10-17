-- From https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/mini.lua#L21-L80
local function ai_whichkey()
  ---@type table<string, string|table>
  local objects = {
    ["$"] = "Entire line",
    a = "Argument",
    b = "Bracket",
    c = "Class",
    d = "Digit(s)",
    D = "Diagnostic",
    e = "Word in CamelCase & snake_case",
    f = "Function call",
    F = "Function",
    g = "Entire file",
    H = "Start of line",
    i = "Indent",
    L = "End of line",
    o = "Block, conditional, loop",
    q = "Quote",
    t = "Tag",
  }

  local ret = { mode = { "o", "x" } }
  local mappings = {
    around = "a",
    inside = "i",
    around_next = "an",
    inside_next = "in",
    around_last = "al",
    inside_last = "il",
  }
  mappings.goto_left = nil
  mappings.goto_right = nil

  for name, prefix in pairs(mappings) do
    name = name:gsub("^around_", ""):gsub("^inside_", "")
    ret[#ret + 1] = { prefix, group = name }
    for key, desc in pairs(objects) do
      ret[#ret + 1] = { prefix .. key, desc = desc }
    end
  end
  require("which-key").add(ret, { notify = false })
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = ai_whichkey
})
