local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s({ trig = "ivec" }, { t({ "#include <vector>", "using std::vector;" }) }),
	s({ trig = "istr" }, { t({ "#include <string>", "using std::string;" }) }),
	s({ trig = "idq" }, { t({ "#include <deque>", "using std::deque;" }) }),
	s({ trig = "iqu" }, { t({ "#include <queue>", "using std::queue;" }) }),
	s({ trig = "imap" }, { t({ "#include <map>", "using std::map;" }) }),
	s({ trig = "iumap" }, { t({ "#include <unordered_map>", "using std::unordered_map;" }) }),
	s({ trig = "iset" }, { t({ "#include <set>", "using std::set;" }) }),
	s({ trig = "iuset" }, { t({ "#include <unordered_set>", "using std::unordered_set;" }) }),
	s({ trig = "ibits" }, { t({ "#include <bits/stdc++.h>", "using namespace std;" }) }),
	s({ trig = "cclass" }, {
		t({ "class " }),
		i(1, "ClassName"),
		t({ " {", "public:", "    " }),
		i(2, "ClassName"),
		t({ "();", "", "private:", "    " }),
		i(3, ""),
		t({ "", "};" }),
	}),
	s({ trig = "hguard" }, {
		t({ "#ifndef " }),
		i(1, "HEADER_GUARD"),
		t({ "", "#define " }),
		i(1),
		t({ "", "", "" }),
		i(2),
		t({ "", "", "#endif // " }),
		i(1),
	}),
}
