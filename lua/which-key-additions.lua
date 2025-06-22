-- From https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/mini.lua#L21-L80
function ai_whichkey()
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
  ---@type table<string, string>
  local mappings = vim.tbl_extend("force", {}, {
    around = "a",
    inside = "i",
    around_next = "an",
    inside_next = "in",
    around_last = "al",
    inside_last = "il",
  }, {})
  mappings.goto_left = nil
  mappings.goto_right = nil

  for name, prefix in pairs(mappings) do
    name = name:gsub("^around_", ""):gsub("^inside_", "")
    ret[#ret + 1] = { prefix, group = name }
    for _, obj in ipairs(objects) do
      local desc = obj.desc
      if prefix:sub(1, 1) == "i" then
        desc = desc:gsub(" with ws", "")
      end
      ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
    end
  end
  require("which-key").add(ret, { notify = false })
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    ai_whichkey()
  end,
})
