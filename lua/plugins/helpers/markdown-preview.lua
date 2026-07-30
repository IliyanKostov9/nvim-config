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

      vim.cmd([[
      function OpenMarkdownPreview(url)
        execute "silent !open -a 'Google Chrome' " . shellescape(a:url)
      endfunction
      ]])
    end,
  },
}
