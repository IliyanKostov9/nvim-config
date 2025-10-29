return {
  {
    "stevearc/conform.nvim",
    lazy = false,
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format { async = true, lsp_fallback = true }
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      formatters = {
        -- NOTE: Commented because ruff_fix and ruff_format does that
        -- ruff = {
        --   command = "ruff format",
        -- },
        ["npm-groovy-lint"] = {
          command = "npm-groovy-lint",
          args = { "--format", "-" },
          stdin = true,
          timeout_ms = 8000,
        },
        ktfmt = {
          args = { "-" },
          comand = "ktfmt",
        },
      },
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        typescript = { "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        xml = { "prettierd" },
        yaml = { "prettierd" },
        yml = { "prettierd" },
        json = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        html = { "prettierd" },
        svg = { "prettierd" },
        -- cpp = { "clang-format" },

        groovy = { "npm-groovy-lint" },
        go = { "golines" },

        -- htmldjango = { "prettierd" },
        python = {
          "ruff_fix",
          "ruff_format",
          "isort",
        },

        java = { "google-java-format" },
        nix = { "alejandra" },
        lua = { "stylua" },
        kotlin = { "ktfmt" },
        -- cs = { "csharpier" },
        sh = { "beautysh" },
      },
      fallback_formatter = "prettierd",
    },
  },
}
