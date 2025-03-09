vim.cmd.hi("Comment gui=none")

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
