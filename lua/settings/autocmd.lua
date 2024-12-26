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
