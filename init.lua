vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local function get_spec()
	if not vim.g.vscode then
		return {
			{ import = "plugins.actions" },
			{ import = "plugins.code" },
			{ import = "plugins.lang" },
			{ import = "plugins.navi" },
			{ import = "plugins.term" },
			{ import = "plugins.git" },
			{ import = "plugins.ui" },
		}
	else
		return { import = "plugins.vscode" }
	end
end

require("vim-options")
require("lazy").setup({
	spec = { get_spec() },
	defaults = {
		-- lazy = true,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"tohtml",
				"tutor",
			},
		},
	},
})
