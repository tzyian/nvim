local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
	s({ trig = "ils" }, { t("from typing import List") }),
	s({ trig = "ihq" }, { t("from heapq import heappush, heappop") }),
	s({ trig = "icd" }, { t("from collections import defaultdict") }),
	s({ trig = "idd" }, { t("from collections import defaultdict") }),
	s({ trig = "icq" }, { t("from collections import deque") }),
	s({ trig = "idq" }, { t("from collections import deque") }),
	s({ trig = "icc" }, { t("from collections import Counter") }),
	s({ trig = "ict" }, { t("from collections import Counter") }),
}
