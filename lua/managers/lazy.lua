local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "tpope/vim-sleuth",

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
}, { require("managers.ui") })
vim.cmd.hi("Comment gui=none")

-- Colors
local schedule_enabled = true
local light_color_theme = "rose-pine-dawn"
local light_color_theme_hex = "#faf4ed"

local dark_color_theme = "kanagawa-dragon"
local dark_color_theme_hex = "#181616"

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
end
