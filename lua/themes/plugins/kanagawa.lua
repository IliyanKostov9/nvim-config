return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup {
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true,
        -- Disabled, because it breakes picom transparency
        dimInactive = false,
        terminalColors = true,
        colors = {
          palette = {},
          theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
              ui = {
                bg_glutter = "none",
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            Pmenu = { fg = theme.ui.shade0, bg = "none" },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            LineNr = { bg = "none" },
            SignColumn = { bg = "none" },
            FoldColumn = { bg = "none" },
            CursorLineNr = { bg = "none" },
          }
        end,
        theme = "wave",
        background = {
          dark = "wave",
          light = "lotus",
        },
      }
    end,
  },
}
--   local function set_color_scheme()
--     local hour = tonumber(os.date("%H"))
--     if hour >= 7 and hour < 20 then
--       vim.cmd.colorscheme("rose-pine-dawn")
--     else
--       -- vim.cmd.colorscheme("kanagawa-wave")
--       vim.cmd.colorscheme("rose-pine")
--     end
--   end
--   set_color_scheme()
--   local timer = vim.loop.new_timer()
--   timer:start(
--     0,
--     3600000,
--     vim.schedule_wrap(function()
--       set_color_scheme()
--     end)
--   )
