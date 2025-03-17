-- Set the path of netrw to always point to the current dir path
-- conditionally if we're not looking at a library
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local path = vim.fn.expand("%:p")
    if vim.fn.filereadable(path) == 1 then
      vim.cmd("lcd " .. vim.fn.fnamemodify(path, ":h"))
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- NOTE: Remove unused Javascipt imports
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("js_imports", { clear = true }),
  pattern = { "*.jsx", "*.tsx" },
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.removeUnused.ts" }, diagnostics = {} }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 500)

    if result then
      for _, res in pairs(result) do
        if res.result then
          for _, action in pairs(res.result) do
            if action.edit then
              vim.lsp.util.apply_workspace_edit(action.edit, "utf-16")
            elseif action.command then
              vim.lsp.buf.execute_command(action)
            end
          end
        end
      end
    end
  end,
})
