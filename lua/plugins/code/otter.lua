return {
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
      "neovim/nvim-lspconfig",
    },
    opts = {},
    config = function()
      require("otter").activate({ "javascript", "python", "sh" }, true, true, nil)
    end,
  },
}
