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
modules.options.core["nvim-java"] = false
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

vim.cmd.hi("Comment gui=none")

local schedule_enabled = false
local light_color_theme = "rose-pine-dawn"
local light_color_theme_hex = "#faf4ed"

local dark_color_theme = "kanagawa-dragon"
local dark_color_theme_hex = "#181616"

local function set_theme()
  -- If scheduled color is enabled
  if schedule_enabled == true then
    local timer = vim.loop.new_timer()
    timer:start(
      0,
      3600000,
      vim.schedule_wrap(function()
        require("settings.funcs").schedule_color_scheme(
          light_color_theme,
          dark_color_theme,
          light_color_theme_hex,
          dark_color_theme_hex
        )
      end)
    )
  else
    -- If not, then enable dark color by default
    vim.cmd.colorscheme(dark_color_theme)
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#859477", bold = true })
  end
end

set_theme()
