return {
  {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons", lazy = true },
    opts = {
      scope = "git",
      icons = true,
      status = true,
    },
    keys = {
      { "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
      { "<leader>r", "<cmd>Grapple untag<cr>", desc = "Untag a file" },
      { "<leader>l", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },
      { "<leader>tl", "<cmd>Telescope grapple tags<cr>", desc = "Telescope toggle tags menu" },
      { "<leader>1", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
      { "<leader>2", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
      { "<leader>3", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
      { "<leader>4", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
      { "<leader>5", "<cmd>Grapple select index=5<cr>", desc = "Select fifth tag" },
      { "<leader>6", "<cmd>Grapple select index=6<cr>", desc = "Select sixth tag" },
      { "<leader>7", "<cmd>Grapple select index=7<cr>", desc = "Select seventh tag" },
      { "<leader>8", "<cmd>Grapple select index=8<cr>", desc = "Select eighth tag" },
      { "<leader>9", "<cmd>Grapple select index=9<cr>", desc = "Select ninth tag" },

      { "<leader>+", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
      { "<leader>-", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
    },
    config = function()
      local grapple = require("grapple")
      grapple.setup {
        scope = "git",
        icons = true,
        status = true,
        statusline = {
          icon = "󰛢",
          active = "[%s]",
          inactive = " %s ",
          include_icon = true,
        },
      }
      require("telescope").load_extension("grapple")
      grapple.statusline()
    end,
  },
}
