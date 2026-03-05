vim.o.spell = true

text_formatting("<leader>cb", "**", "**", "Bold")
text_formatting("<leader>ci", "_", "_", "Italic")
-- markdown doesn't have underline
text_formatting("<leader>cc", "`", "`", "Code")
text_formatting("<leader>cs", "~~", "~~", "Strikethrough")
text_formatting("<leader>cm", "$", "$", "Strikethrough")
