require("settings.funcs")

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste the text without copying the old text" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Remain cursor in the middle when scrolling up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Remain cursor in the middle when scrolling down" })

vim.keymap.set("n", "<C-p>", vim.cmd.Ex, { desc = "Shortcut for :Ex" })

vim.keymap.set("n", "<leader>`", function()
  local path = vim.fn.expand("%:p:h")
  vim.cmd("silent !tmux split-window -v -c " .. path, " -p 5")
end, { desc = "Create a horizontal tmux pane for VSCode like cmd", noremap = true, silent = true })

vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle, { desc = "Undo tree" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C---[[ w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("i", "jk", _G.better_escape_vim, { desc = "Better escape vim jk", noremap = true, silent = true })
vim.keymap.set("i", "jj", _G.better_escape_vim, { desc = "Better escape vim jj", noremap = true, silent = true })

vim.keymap.set("n", "<leader>lx", disable_lsp, { desc = "Disable LSP" })

vim.keymap.set("n", "<M-z>", "<cmd>:set wrap!<cr>", { desc = "Auto wrap", noremap = true, silent = true })

vim.keymap.set("n", "<leader>ln", change_line_number, { desc = "Set line number", noremap = true, silent = true })

vim.keymap.set(
  "n",
  "<C-g>",
  cd_to_git_root,
  { desc = "Go to the root of the git project", noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>gweb", "<cmd>Git browse<cr>", { desc = "Navigate to git remote via browser" })
