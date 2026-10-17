local M = {}

local default_shortcuts = {
  ["c"] = "*.{c,cpp}",
  ["h"] = "*.{h,hpp}",
  ["g"] = "*.go",
  ["p"] = "*.proto",
  ["py"] = "*.py",
  ["md"] = "*.md",
  ["l"] = "*.lua",
  ["t"] = "*.{ts,tsx}",
  ["j"] = "*.{js,jsx}",
  ["r"] = "*.rs",
}

local function parse_globs(glob_str, shortcuts)
  local globs = {}
  local current = {}
  local depth = 0

  local function add()
    local raw = vim.trim(table.concat(current))
    if raw ~= "" then
      local is_exclude = raw:sub(1, 1) == "!"
      local key = is_exclude and raw:sub(2) or raw
      local pattern = shortcuts[key] or key
      table.insert(globs, is_exclude and ("!" .. pattern) or pattern)
    end
    current = {}
  end

  for i = 1, #glob_str do
    local char = glob_str:sub(i, i)
    if char == "{" then depth = depth + 1 end
    if char == "}" then depth = math.max(0, depth - 1) end
    if (char == "," or char == " " or char == "\t") and depth == 0 then
      add()
    else
      current[#current + 1] = char
    end
  end
  add()
  return globs
end

function M.live_grep(opts)
  opts = opts or {}
  local shortcuts = vim.tbl_extend("force", default_shortcuts, opts.shortcuts or {})
  local Snacks = require("snacks")

  return Snacks.picker.pick(vim.tbl_deep_extend("force", {
    source = "multigrep",
    title = "Multi Grep",
    prompt = "Search > ",
    live = true,
    supports_live = true,
    show_empty = true,
    notify = false,
    format = "file",
    finder = function(finder_opts, ctx)
      local search = ctx.filter.search
      if not search or search == "" then
        return {}
      end

      -- Split once on the first double-space: pattern  globs
      local pattern, glob_str = search:match("^(.-)%s%s+(.*)$")
      pattern = pattern or search

      if pattern == "" then
        return {}
      end

      local args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--max-columns=500",
        "--glob=!.git",
      }

      if glob_str and glob_str ~= "" then
        for _, glob in ipairs(parse_globs(glob_str, shortcuts)) do
          table.insert(args, "-g")
          table.insert(args, glob)
        end
      end

      vim.list_extend(args, finder_opts.args or {})
      vim.list_extend(args, { "--", pattern })

      local cwd = ctx:cwd()
      return require("snacks.picker.source.proc").proc({
        cmd = "rg",
        args = args,
        cwd = cwd,
        notify = false,
        transform = function(item)
          local file, line, col, text = item.text:match("^(.+):(%d+):(%d+):(.*)$")
          if not file then return false end

          item.cwd = cwd
          item.file = file
          item.line = text
          item.pos = { tonumber(line), tonumber(col) - 1 }
        end,
      }, ctx)
    end,
  }, opts))
end

return M
