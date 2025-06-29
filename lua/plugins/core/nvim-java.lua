return {
  "nvim-java/nvim-java",
  ft = { "java" },
  config = function()
    require("java").setup {
      notifications = {
        dap = false,
      },
      jdk = {
        -- NOTE: keep it disabled, due to avoid receiving The type java.lang.Object cannot be resolved
        auto_install = true,
      },
      spring_boot_tools = {
        enable = false,
      },
      java_debug_adapter = {
        enable = true,
      },
    }

    local function fixDeadlockGradleIssue()
      -- INFO: fix provided: https://github.com/mfussenegger/nvim-jdtls/issues/38
      local lspconfig_util = require("lspconfig.util")
      local root_markers = { "build.gradle", "pom.xml" }
      local root_pattern = lspconfig_util.root_pattern(unpack(root_markers))
      local root_dir = root_pattern(vim.fn.getcwd())

      if root_dir ~= nil then
        local f = io.open(root_dir .. "/build.gradle", "r")
        if f ~= nil then
          io.close(f)
          vim.api.nvim_exec(
            [[
          let test#java#runner = 'gradletest'
        ]],
            true
          )
          os.execute("rm -rf " .. root_dir .. "/.settings")
        end
      end
    end

    -- fixDeadlockGradleIssue()
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
