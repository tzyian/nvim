vim.o.spell = true
vim.o.wrap = true

Text_Format("<leader>cb", "**", "**", "Bold")
Text_Format("<leader>ci", "_", "_", "Italic")
-- markdown doesn't have underline
Text_Format("<leader>cc", "`", "`", "Code")
Text_Format("<leader>cs", "~~", "~~", "Strikethrough")
Text_Format("<leader>cm", "$", "$", "Strikethrough")
