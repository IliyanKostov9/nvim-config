return {
  "maxmx03/solarized.nvim",
  lazy = false,
  priority = 1000,
  ---@type solarized.config
  opts = {
    transparent = {
      enabled = true, -- Master switch to enable transparency
      pmenu = true, -- Popup menu (e.g., autocomplete suggestions)
      normal = true, -- Main editor window background
      normalfloat = true, -- Floating windows
      neotree = true, -- Neo-tree file explorer
      nvimtree = true, -- Nvim-tree file explorer
      whichkey = true, -- Which-key popup
      telescope = true, -- Telescope fuzzy finder
      lazy = true, -- Lazy plugin manager UI
      mason = true, -- Mason manage external tooling
    },
    on_highlights = nil,
    on_colors = nil,
    palette = "solarized", -- solarized (default) | selenized
    variant = "winter", -- "spring" | "summer" | "autumn" | "winter" (default)
    error_lens = {
      text = false,
      symbol = false,
    },
    styles = {
      types = {},
      functions = {},
      parameters = {},
      comments = {},
      strings = {},
      keywords = {},
      variables = {},
      constants = {},
    },
    plugins = {
      treesitter = true,
      lspconfig = true,
      navic = true,
      cmp = true,
      indentblankline = true,
      neotree = true,
      nvimtree = true,
      whichkey = true,
      dashboard = true,
      gitsigns = true,
      telescope = true,
      noice = true,
      hop = true,
      ministatusline = true,
      minitabline = true,
      ministarter = true,
      minicursorword = true,
      notify = true,
      rainbowdelimiters = true,
      bufferline = true,
      lazy = true,
      rendermarkdown = true,
      ale = true,
      coc = true,
      leap = true,
      alpha = true,
      yanky = true,
      gitgutter = true,
    },
  },
  config = function(_, opts)
    vim.o.termguicolors = true
    vim.o.background = "light"
    require("solarized").setup(opts)
    vim.cmd.colorscheme("solarized")
  end,
}
