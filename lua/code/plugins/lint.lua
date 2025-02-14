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
        json = { "jsonlint" },
        yaml = { "yamllint" },
        yml = { "yamllint" },
        python = { "pylint" },
        -- ansible = { "ansible-lint" },
        -- kotlin = { "ktlint" },
        -- javascript = { "eslint_d" },
        -- typescript = { "eslint_d" },
        -- javascriptreact = { "eslint_
        -- typescriptreact = { "eslint_
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
