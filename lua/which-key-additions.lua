-- From https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/mini.lua#L21-L80
local function ai_whichkey()
  ---@type table<string, string|table>
  local objects = {
    a = "Argument",
    c = "Class",
    d = "Digit(s)",
    e = "Word in CamelCase & snake_case",
    f = "Function call",
    F = "Function",
    g = "Entire file",
    i = "Indent",
    o = "Block, conditional, loop",
    q = "Quote",
    t = "Tag",
    u = "Use/call function & method",
    U = "Use/call without dot in name",
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
