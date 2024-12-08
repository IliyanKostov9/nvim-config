return {
  "nvim-java/nvim-java",
  config = function()
    require("java").setup {
      notifications = {
        dap = false,
      },
      jdk = {
        -- TODO: dynamically set it to false, for Java > 8
        auto_install = false,
      },
      spring_boot_tools = {
        enable = false,
      },
      java_debug_adapter = {
        enable = false,
      },
    }

    require("lspconfig").jdtls.setup {}
  end,
  dependencies = {
    "nvim-java/lua-async-await",
    "nvim-java/nvim-java-refactor",
    "nvim-java/nvim-java-core",
    "nvim-java/nvim-java-test",
    "nvim-java/nvim-java-dap",
    "MunifTanjim/nui.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    {
      "williamboman/mason.nvim",
      opts = {
        registries = {
          "github:nvim-java/mason-registry",
          "github:mason-org/mason-registry",
        },
      },
    },
  },
}
