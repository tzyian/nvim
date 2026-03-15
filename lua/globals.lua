-- Text formatting for visual mode
function Text_Format(key, prefix, suffix, desc)
  vim.keymap.set("v", key, function()
    vim.cmd('normal! "xy')
    local selection = vim.fn.getreg("x")
    local wrapped = prefix .. selection .. suffix
    vim.fn.setreg("x", wrapped)
    vim.cmd('normal! gv"xp')
  end, { buffer = true, desc = desc })
end

function map(mode, key, func, desc, opts)
  opts = vim.tbl_deep_extend("force", {
    silent = true,
  }, opts or {})
  if desc then
    opts.desc = desc
  end
  vim.keymap.set(mode, key, func, opts)
end

function nmap(key, func, desc, opts)
  map("n", key, func, desc, opts)
end

function tmap(key, func, desc, opts)
  map("t", key, func, desc, opts)
end

function imap(key, func, desc, opts)
  map("i", key, func, desc, opts)
end
