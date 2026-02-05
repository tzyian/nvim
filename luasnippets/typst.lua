local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s({ trig = "eg" }, {
    t("#example["),
    i(1, "text"),
    t("]"),
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
  s({ trig = "tab", name = "Table" }, {
    t({ "#table(", "  columns: " }),
    i(1, "2"),
    t({ ",", "  [*" }),
    i(2, "header1"),
    t("*], [*"),
    i(3, "header2"),
    t({ "*],", ")", "" }),
    i(0)
  })

}
