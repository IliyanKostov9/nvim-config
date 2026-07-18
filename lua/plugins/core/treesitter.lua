return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    config = function()
      vim.g.nvim_treesitter = {
        ensure_installed = "all",
        auto_install = true,
      }

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)

          if lang and lang ~= "tex" and lang ~= "latex" then
            pcall(vim.treesitter.start)
          end
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ruby",
        callback = function()
          vim.bo.syntax = "on"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,
        max_lines = 1,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 3,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
        zindex = 20,
        on_attach = nil,
      }
    end,
  },
}
