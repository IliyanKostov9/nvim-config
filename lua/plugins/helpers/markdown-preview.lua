return {
  {
    -- Install markdown preview, use npx if available.
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_browserfunc = "OpenMarkdownPreview"

      local open_cmd = vim.fn.has("macunix") == 1 and "open" or "xdg-open"

      vim.cmd(string.format(
        [[
      function OpenMarkdownPreview(url)
        call jobstart(['%s',a:url], {'detach': v:true})
      endfunction
      ]],
        open_cmd
      ))
    end,
  },
}
