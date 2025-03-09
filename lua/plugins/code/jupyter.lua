return {
  "dccsillag/magma-nvim",
  event = "InsertEnter",
  dependencies = { "rcarriga/nvim-notify" },
  config = function()
    vim.api.nvim_set_keymap(
      "n",
      "<LocalLeader>r",
      ":MagmaEvaluateOperator<CR>",
      { noremap = true, silent = true, expr = true }
    )
    vim.api.nvim_set_keymap("n", "<LocalLeader>rr", ":MagmaEvaluateLine<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("x", "<LocalLeader>r", ":<C-u>MagmaEvaluateVisual<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<LocalLeader>rc", ":MagmaReevaluateCell<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<LocalLeader>rd", ":MagmaDelete<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<LocalLeader>ro", ":MagmaShowOutput<CR>", { noremap = true, silent = true })

    vim.g.magma_automatically_open_output = false
    vim.g.magma_image_provider = "ueberzug"

    function MagmaInitPython()
      vim.cmd("MagmaInit python3")
      vim.cmd("MagmaEvaluateArgument a=5")
    end

    function MagmaInitCSharp()
      vim.cmd([[
      :MagmaInit .net-csharp
      :MagmaEvaluateArgument Microsoft.DotNet.Interactive.Formatting.Formatter.SetPreferredMimeTypesFor(typeof(System.Object),"text/plain");
      ]])
    end

    vim.cmd([[
    :command MagmaInitPython lua MagmaInitPython()
    :command MagmaInitCSharp lua MagmaInitCSharp()
    :command MagmaInitFSharp lua MagmaInitFSharp()
    ]])
  end,
}
