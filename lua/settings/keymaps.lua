require("settings.funcs")

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste the text without copying the old text" })

vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Remain cursor in the middle when scrolling up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Remain cursor in the middle when scrolling down" })

vim.keymap.set("n", "<C-p>", vim.cmd.Ex, { desc = "Shortcut for :Ex" })

vim.keymap.set("n", "<leader>`", function()
  local current_dir = vim.fn.expand("%:p:h")
  vim.cmd("silent !tmux split-window -v -c " .. current_dir, " -p 5")
end, { desc = "Create a horizontal tmux pane for VSCode like cmd", noremap = true, silent = true })

vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle, { desc = "Undo tree" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C---[[ w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.api.nvim_set_keymap(
  "i",
  "jk",
  [[<cmd>lua _G.better_escape_vim()<CR>]],
  { desc = "Better escape vim jk", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "i",
  "jj",
  [[<cmd>lua _G.better_escape_vim()<CR>]],
  { desc = "Better escape vim jj", noremap = true, silent = true }
)

vim.keymap.set("n", "<leader>lx", disable_lsp, { desc = "Disable LSP" })

vim.api.nvim_set_keymap("n", "<M-z>", ":set wrap!<CR>", { desc = "Auto wrap", noremap = true, silent = true })

vim.api.nvim_set_keymap(
  "n",
  "<leader>ln",
  ":lua change_line_number()<CR>",
  { desc = "Set line number", noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<C-g>",
  ":lua cd_to_git_root()<CR>",
  { desc = "Go to the root of the git project", noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>gweb", "<cmd>Git browse<cr>", { desc = "Navigate to git remote via browser" })
