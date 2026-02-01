local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

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
}
