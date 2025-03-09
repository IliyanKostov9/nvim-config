local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local modules = require("modules.init")
modules.options.code.autopairs = true
modules.options.code.lint = true
modules.options.code.debug = true

modules.options.core.telescope = true
modules.options.core["nvim-java"] = true
modules.options.core.lspconfig = true
modules.options.core.conform = true
modules.options.core.grapple = true
modules.options.core.cmp = true
modules.options.core.mini = true
modules.options.core.treesitter = true

modules.options.git["vim-fugitive"] = true
modules.options.git.gitsigns = true

modules.options.helpers["which-key"] = true
modules.options.helpers["todo-comments"] = true
modules.options.helpers.undotree = true
modules.options.helpers.Comment = true
modules.options.helpers["markdown-preview"] = true

modules.options.themes.kanagawa = true
modules.options.themes["vim-devicons"] = true

modules.options.tracking.wakatime = true

local modules_plugins = modules.get_plugins()

require("lazy").setup({
  modules_plugins,
}, { require("managers.ui") })

schedule_enabled = false
light_color_theme = "rose-pine-dawn"
light_color_theme_hex = "#faf4ed"

dark_color_theme = "kanagawa-dragon"
dark_color_theme_hex = "#181616"
