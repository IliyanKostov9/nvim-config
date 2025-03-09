return {
  {
    "echasnovski/mini.nvim",
    config = function()
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      require("mini.ai").setup { n_lines = 500 }
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()
      require("mini.move").setup()
      require("mini.basics").setup {
        mappings = {
          basics = true,
          option_toggle_prefix = [[\]],
          windows = false,
          move_with_alt = false,
        },
      }

      local enable_status_line = false

      if enable_status_line then
        local statusline = require("mini.statusline")

        statusline.setup {
          use_icons = vim.g.have_nerd_font,
          content = {
            active = function()
              local mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
              local git = MiniStatusline.section_git { trunc_width = 75 }
              local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
              local filename = MiniStatusline.section_filename { trunc_width = 75 }
              local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
              local grapple_status = ""
              if package.loaded["grapple"] and require("grapple").exists() then
                grapple_status = require("grapple").statusline()
              end
              local location = MiniStatusline.section_location { trunc_width = 75 }

              return MiniStatusline.combine_groups {
                -- NOTE: Disable statusline, bc of settings.options -> vim.opt.showmode
                -- { hl = mode_hl, strings = { mode } },
                { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
                "%<",
                { hl = "MiniStatuslineFilename", strings = { filename } },
                { hl = "MiniStatuslineGrapple", strings = { grapple_status } },
                "%=",
                { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                { hl = mode_hl, strings = { location } },
              }
            end,
          },
        }
        -- require("transparent").setup()
        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
          return "%2l:%-2v"
        end
      end
    end,
  },
}
