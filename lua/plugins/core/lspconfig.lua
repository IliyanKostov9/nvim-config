return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- NOTE: nvim-java is incomptabile with mason version 2: https://github.com/nvim-java/nvim-java/issues/384
      { "williamboman/mason.nvim", config = true, version = "^1.0.0" }, -- NOTE: Must be loaded before dependants
      { "williamboman/mason-lspconfig.nvim", version = "^1.0.0" },
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      { "j-hui/fidget.nvim", opts = {} },
      {
        "folke/lazydev.nvim",
        opts = {
          -- saghen/blink.cmp
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            "LazyVim",
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      -- TODO: Requires fuzzy cargo dep
      -- use:'cd /home/$(whoami)/.local/share/nvim/lazy/blink.cmp`
      -- `nix run .#build-plugin`
      {
        "saghen/blink.cmp",
        dependencies = "rafamadriz/friendly-snippets",
        opts = {
          sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
              lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100,
              },
            },
          },
        },
      },
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("<leader>R", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
          map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          -- When you move your cursor, the highlights will be cleared
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
              end,
            })
          end
          -- The following autocommand is used to enable inlay hints in your
          -- This may be unwanted, since they displace some of your code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      local servers = {
        yamlls = {},
        basedpyright = {},
        dockerls = {},
        ts_ls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {

        -- NOTE: Ansible
        -- "ansible-language-server",
        -- "ansible-lint",

        -- NOTE: Terraform
        -- "terraform-ls",
        -- "tflint",

        -- NOTE: Python
        "black",
        "mypy",
        "ruff",
        "isort",

        -- NOTE: Java
        "google-java-format",

        -- NOTE: Kotlin
        -- "kotlin-debug-adapter",
        -- "kotlin-language-server",
        -- "ktfmt",

        -- NOTE:C#
        -- "csharp-language-server",
        -- "csharpier",

        -- NOTE: Lua
        "stylua",

        -- NOTE: Nix
        -- NOTE: Requires prior to  use `rustup default stable`
        "alejandra",
        "rnix-lsp",

        -- NOTE: Bash
        -- "bash-language-server",
        -- "beautysh",

        -- NOTE: Utils
        "editorconfig-checker",
        "prettierd",
        "yamllint",
        "jsonlint",
      })

      require("mason-lspconfig").setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }

      -- BUG: ts_server is not working: https://github.com/nvim-lua/kickstart.nvim/pull/1475
      -- @type MasonLspconfigSettings
      -- @diagnostic disable-next-line: missing-fields
      -- require("mason-lspconfig").setup {
      --   automatic_enable = vim.tbl_keys(servers or {}),
      -- }
      -- require("mason-tool-installer").setup { ensure_installed = ensure_installed }
      -- -- Installed LSPs are configured and enabled automatically with mason-lspconfig
      -- -- The loop below is for overriding the default configuration of LSPs with the ones in the servers table
      -- for server_name, config in pairs(servers) do
      --   vim.lsp.config(server_name, config)
      -- end
      vim.lsp.set_log_level("WARN")
    end,
  },
}
