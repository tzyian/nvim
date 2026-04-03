local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local r = ls.restore_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local function push_row(nodes, cols, idx, key_fn)
  for col = 1, cols do
    table.insert(nodes, t("["))
    table.insert(nodes, r(idx, key_fn(col), i(1)))
    table.insert(nodes, t("]"))
    idx = idx + 1
    if col < cols then
      table.insert(nodes, t(", "))
    end
  end
  return idx
end

local function build_table_nodes(rows, cols)
  local nodes = {}
  local idx = 1

  table.insert(nodes, t("table.header("))
  idx = push_row(nodes, cols, idx, function(col)
    return "h" .. col
  end)

  table.insert(nodes, t({ "),", "  " }))

  for row = 1, rows do
    idx = push_row(nodes, cols, idx, function(col)
      return row .. "x" .. col
    end)
    if row < rows then
      table.insert(nodes, t({ ",", "  " }))
    else
      table.insert(nodes, t(","))
    end
  end

  return nodes
end

local dynamic_args = {
  function(snip)
    snip.rows = (snip.rows or 1) + 1
  end,
  function(snip)
    snip.rows = math.max((snip.rows or 1) - 1, 1)
  end,
}

local function table_from_regex(_, snip)
  snip.rows = snip.rows or tonumber(snip.captures[1]) or 1
  local cols = tonumber(snip.captures[2]) or 2
  return sn(nil, build_table_nodes(snip.rows, cols))
end

local function table_dynamic(args, snip)
  local cols = tonumber(args[1][1]) or 2
  snip.rows = snip.rows or 1
  return sn(nil, build_table_nodes(snip.rows, cols))
end

return {
  -- type tab3x4 for a 3 row, 4 col table
  s(
    { trig = "tab(%d+)x(%d+)", regTrig = true, name = "table_regex" },
    fmt([[
#table(
  columns: {},
  {}
)
]], {
      f(function(_, snip)
        return snip.captures[2]
      end),
      d(1, table_from_regex, {}, {
        user_args = dynamic_args,
      }),
    })
  ),

  -- type tab then use choice nodes to add rows
  s(
    { trig = "tab", name = "table" },
    fmt([[
#table(
  columns: {},
  {}
)
]], {
      i(1, "2"),
      d(2, table_dynamic, { 1 }, {
        user_args = dynamic_args,
      }),
    })
  ),

  s({ trig = "ersp" }, {
    t("event/relation/situation/property"),
  }),

  s({ trig = "eg" }, {
    t("#example["),
    i(1, "text"),
    t("]"),
    i(0),
  }),

  s({ trig = "ub" }, {
    t('#math.underbrace(['),
    i(1, 'text'),
    t('],['),
    i(2, 'annot'),
    t('])'),
    i(0),
  }),

  s({ trig = "sc" }, {
    t("#smallcaps["),
    i(1, "text"),
    t("]"),
    i(0),
  }),

  s({ trig = "ul" }, {
    t("#underline["),
    i(1, "text"),
    t("]"),
    i(0),
  }),
}
