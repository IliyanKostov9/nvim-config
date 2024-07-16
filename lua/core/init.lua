return {
  require("core.plugins.telescope"),
  -- Setup nvim java before lspconfig!!
  require("core.plugins.nvim-java"),
  require("core.plugins.lspconfig"),
  require("core.plugins.conform"),
  -- Not working for global harpooned files (e.g it resets whenever I go up to a directory)
  -- require("core.plugins.harpoon"),
  require("core.plugins.grapple"),
  require("core.plugins.cmp"),
  require("core.plugins.mini"),
  require("core.plugins.treesitter"),
  require("core.plugins.luarocks"),
}
