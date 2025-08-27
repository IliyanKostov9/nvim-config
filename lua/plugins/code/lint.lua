return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        -- markdown = { "markdownlint" },
        -- terraform = { "tflint" },
        -- dockerfile = { "hadolint" },
        -- ansible = { "ansible-lint" },
        -- kotlin = { "ktlint" },
        -- javascript = { "eslint_d" },
        -- typescript = { "eslint_d" },
        -- javascriptreact = { "eslint_d" },
        -- typescriptreact = { "eslint_d" },
        json = { "jsonlint" },
        yaml = { "yamllint" },
        yml = { "yamllint" },
        sh = { "shellcheck" },
        groovy = { "npm-groovy-lint" },
        python = { "ruff" },
        cpp = { "cpplint" },
      }
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['json'] = nil
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
