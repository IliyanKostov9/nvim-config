return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    init = function()
      require("nvim-treesitter").install {
        -- NOTE: Languages
        "python",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "groovy",
        "c",
        "cpp",
        "kotlin",
        "java",
        "javascript",
        "lua",
        "luadoc",
        "sql",
        "terraform",
        "nix",
        "tsx",
        "typescript",

        -- NOTE: IaC
        "hcl",
        "helm",

        -- NOTE: Configuration
        "json",
        "json5",
        "toml",
        "editorconfig",
        "xml",
        "yaml",
        "requirements",

        -- NOTE: Shells
        "zsh",
        "bash",

        -- NOTE: Containers
        "dockerfile",
        "make",

        -- NOTE: Documentation
        "markdown",
        "markdown_inline",

        -- NOTE: Vim
        "vim",
        "vimdoc",

        -- NOTE: Git
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "diff",

        -- NOTE: Markup
        "html",
        "css",

        -- NOTE: HTTP
        "http",
        "jq",
        "nginx",
        "query",
        "regex",
      }
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          local skip_langs = { "tex", "latex", "netrw", "fidget", "grapple", "mason", "lazy" }

          if not lang or vim.tbl_contains(skip_langs, lang) then
            return
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
