local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
require("lazy").setup({
	"tpope/vim-sleuth",

	-- NOTE: Plugins.

	-- Core plugins
	require("core.init"),
	-- Tracking plugins
	require("tracking.init"),
	-- Helpers plugins
	require("helpers.init"),
	-- Git plugins
	require("git.init"),
	-- Code plugins
	require("code.init"),
	-- FSO plugins
	require("fso.init"),
	-- Themes
	require("themes.init"),
	--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	--    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
	-- { import = 'custom.plugins' },
}, { require("managers.ui") })
