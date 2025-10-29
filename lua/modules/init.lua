local M = {}

M.options = {

  builtins = {
    ["vim-sleuth"] = true,
  },

  code = {
    indent_line = false,
    otter = false,
    jupyter = false,
    autopairs = false,
    flutter = false,
    lint = false,
    debug = false,
  },

  core = {
    telescope = false,
    ["nvim-java"] = false,
    lspconfig = false,
    conform = false,
    harpoon = false,
    grapple = false,
    cmp = false,
    mini = false,
    treesitter = false,
  },

  fso = {
    ["neo-tree"] = false,
  },

  git = {
    ["vim-fugitive"] = false,
    gitsigns = false,
  },

  helpers = {
    ["which-key"] = false,
    ["todo-comments"] = false,
    ["better-escape"] = false,
    undotree = false,
    Comment = false,
    ["markdown-preview"] = false,
    ["ltex-ls"] = false,
  },

  themes = {
    ["rose-pine"] = false,
    kanagawa = false,
    gruvbox = false,
    solarized = false,
    ["vim-devicons"] = false,
    everforest = false,
    zenburn = false,
    ["tomorrow-night"] = false,
    nightfox = false,
    material = false,
    paper = false,
  },

  tracking = {
    wakatime = false,
  },
}

M.get_plugins = function()
  local plugins = {}

  for mod, mod_table in pairs(M.options) do
    for plugin, enabled in pairs(mod_table) do
      if enabled then
        table.insert(plugins, require("plugins." .. mod .. "." .. plugin))
      end
    end
  end

  return plugins
end

return M
