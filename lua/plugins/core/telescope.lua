return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
      require("telescope").setup {
        defaults = {
          dynamic_preview_title = true,
          --   mappings = {
          --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          --   },
        },
        -- pickers = {}
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      }
      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      local funcs = require("settings.funcs")

      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>fp", function()
        builtin.find_files {
          cwd = funcs.get_git_root(),
        }
      end, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>gr", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>gp", function()
        builtin.live_grep {
          cwd = funcs.get_git_root(),
        }
      end, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
      vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = "[/] Fuzzily search in current buffer" })

      -- Find & replace
      vim.keymap.set("n", "<leader>fr", function()
        local find_text = vim.fn.input("Find: ")
        local replace_text = vim.fn.input("Replace: ")

        vim.cmd(string.format("args `rg '%s' -l`", find_text))
        pcall(function()
          vim.cmd(
            string.format(
              "argdo %%s/%s/%s/gc | update",
              vim.fn.escape(find_text, "/"),
              vim.fn.escape(replace_text, "/")
            )
          )
        end)
      end, { desc = "[F]ind and [R]eplace" })

      -- Marks
      vim.keymap.set("n", "<leader>mm", builtin.marks, { desc = "List all [M]arks for [M]om" })
      -- Jumplist
      vim.keymap.set("n", "<leader>jp", builtin.jumplist, { desc = "List all [J]u[M][P]s" })
      -- Git
      local function check_if_user_in_git(builtin_fn)
        local is_user_in_git_repo = pcall(function()
          builtin_fn()
        end)
        if not is_user_in_git_repo then
          print("You are not in git project!!!")
        end
      end

      vim.keymap.set("n", "<leader>gg", function()
        check_if_user_in_git(builtin.git_files)
      end, { desc = "Search [G]it files for [G]ood" })

      vim.keymap.set("n", "<leader>gf", function()
        check_if_user_in_git(builtin.git_status)
      end, { desc = "Show the [G]it d[I][F][F]erence for changed files" })

      vim.keymap.set("n", "<leader>br", function()
        check_if_user_in_git(builtin.git_branches)
      end, { desc = "List all local and remote [G]it [B][R]anches" })

      vim.keymap.set("n", "<leader>cm", function()
        check_if_user_in_git(builtin.git_commits)
      end, { desc = "List all [G]it [C]o[M]mits" })

      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set("n", "<leader>s/", function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        }
      end, { desc = "[S]earch [/] in Open Files" })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files { cwd = vim.fn.stdpath("config") }
      end, { desc = "[S]earch [N]eovim files" })
    end,
  },
}
