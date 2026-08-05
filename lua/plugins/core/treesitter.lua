local function gsx_build(dir)
  vim.fn.mkdir(dir .. "/parser", "p")
  local out = vim.fn.system { "tree-sitter", "build", "-o", dir .. "/parser/gsx.so", dir }
  if vim.v.shell_error ~= 0 then
    vim.notify("tree-sitter-gsx: parser build failed:\n" .. out, vim.log.levels.ERROR)
    return
  end
  vim.fn.mkdir(dir .. "/queries/gsx", "p")
  for _, q in ipairs { "highlights", "injections" } do
    vim.uv.fs_copyfile(dir .. "/queries/" .. q .. ".scm", dir .. "/queries/gsx/" .. q .. ".scm")
  end
end

-- True when the compiled parser is absent or older than the generated grammar.
local function gsx_stale(dir)
  local so = vim.uv.fs_stat(dir .. "/parser/gsx.so")
  if not so then
    return true
  end
  local src = vim.uv.fs_stat(dir .. "/src/parser.c")
  return src ~= nil and src.mtime.sec > so.mtime.sec
end

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
  {
    "gsxhq/tree-sitter-gsx",
    lazy = false,
    build = function(plugin)
      gsx_build(plugin.dir)
    end, -- on install / :Lazy update
    init = function()
      vim.filetype.add { extension = { gsx = "gsx" } }
    end,
    config = function(plugin)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "gsx",
        callback = function(ev)
          if gsx_stale(plugin.dir) then
            gsx_build(plugin.dir)
          end -- safety net
          pcall(vim.treesitter.start, ev.buf, "gsx")
          vim.bo[ev.buf].commentstring = "// %s"
        end,
      })
    end,
  },
}
