local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s({ trig = "ils" }, { t("from typing import List") }),
	s({ trig = "itl" }, { t("from typing import List") }),
	s({ trig = "ilo" }, { t("from typing import Optional") }),
	s({ trig = "ito" }, { t("from typing import Optional") }),
	s({ trig = "ihq" }, { t("from heapq import heappush, heappop, heapify") }),
	s({ trig = "icd" }, { t("from collections import defaultdict") }),
	s({ trig = "idd" }, { t("from collections import defaultdict") }),
	s({ trig = "icq" }, { t("from collections import deque") }),
	s({ trig = "idq" }, { t("from collections import deque") }),
	s({ trig = "icc" }, { t("from collections import Counter") }),
	s({ trig = "ict" }, { t("from collections import Counter") }),
	s({ trig = "ifc" }, { t("from functools import cache") }),
	s({ trig = "ibl" }, { t("from bisect import bisect_left, bisect_right") }),
	s({ trig = "ibr" }, { t("from bisect import bisect_left, bisect_right") }),
	s({ trig = "ipr" }, {
		t("x = Solution()."),
		i(1),
		t({ "", "print(x)" }),
	}),
	s({ trig = "pguard" }, {
		t({ "if __name__ == \"__main__\":", "    " }),
		i(1),
	}),
	s({ trig = "pclass" }, {
		t({ "class " }),
		i(1, "ClassName"),
		t({ ":", "    def __init__(self" }),
		i(2),
		t({ "):", "        " }),
		i(3, "pass"),
	}),
	s({ trig = "pytest" }, {
		t({ "def test_" }),
		i(1, "name"),
		t({ "():", "    " }),
		i(2, "assert True"),
	}),
}
