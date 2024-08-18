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
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        colors = {
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors)
          return {}
        end,
        theme = "wave",
        background = {
          dark = "wave",
          light = "lotus",
        },
      }
      vim.cmd.colorscheme("kanagawa")
      -- vim.cmd.colorscheme("kanagawa-wave")
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
      vim.cmd.hi("Comment gui=none")
    end,
  },
}
