return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    -- init = function()
    --   require("nvim-treesitter").install {
    --     "python",
    --     "lua",
    --     "nix",
    --     "vim",
    --     "vimdoc",
    --   }
    -- end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          local skip_langs = { "tex", "latex", "netrw", "fidget", "grapple", "mason", "lazy" }

          if not lang or vim.tbl_contains(skip_langs, lang) then
            return
          end

          -- Auto-install the parser if it's not already installed
          if not vim.tbl_contains(require("nvim-treesitter.config").get_installed(), lang) then
            require("nvim-treesitter").install({ lang }):wait(30000)
          end

          pcall(vim.treesitter.start)
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
