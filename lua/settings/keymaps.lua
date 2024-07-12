-- Functions start from here

-- Eg, better escape vim
function _G.custom_escape()
  vim.api.nvim_input("<Esc>")
  local current_line = vim.api.nvim_get_current_line()
  if current_line:match("^%s+$") then
    vim.api.nvim_set_current_line("")
  end
end

function ChangeToGitRoot()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if git_root == nil or git_root == "" then
    print("Not in a Git repository")
  else
    vim.cmd("Explore" .. vim.fn.fnameescape(git_root))
  end
end

-- Keybindings start from here

-- e.g if you don't want the copy-paste to store the removed word to the registry do:
-- yaw -> vaw -> <leader> + p
vim.keymap.set("x", "<leader>p", '"_dP')
-- Neoscroll
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Remain cursor in the middle when scrolling up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Remain cursor in the middle when scrolling down" })
-- Shortcut for Explore Ex
vim.keymap.set("n", "<C-p>", vim.cmd.Ex, { desc = "Shortcut for :Ex" })

-- Tmux
-- Open a pane in the current path of nvim
vim.keymap.set("n", "<leader>`", function()
  local current_dir = vim.fn.expand("%:p:h")
  vim.cmd("silent !tmux split-window -v -c " .. current_dir, " -p 5")
end, { noremap = true, silent = true })

-- Undotree hotkey
vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)
-- -- Set the path of netrw to always point to the current dir path
vim.cmd("autocmd BufEnter * lcd %:p:h")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C---[[ w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Better escape vim commands
vim.api.nvim_set_keymap("i", "jk", [[<cmd>lua _G.custom_escape()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "jj", [[<cmd>lua _G.custom_escape()<CR>]], { noremap = true, silent = true })

-- Disable LSP
local isLspDiagnosticsVisible = true
vim.keymap.set("n", "<leader>lx", function()
  isLspDiagnosticsVisible = not isLspDiagnosticsVisible
  vim.diagnostic.config {
    virtual_text = isLspDiagnosticsVisible,
    underline = isLspDiagnosticsVisible,
  }
end)

-- Auto-wrap
vim.api.nvim_set_keymap("n", "<M-z>", ":set wrap!<CR>", { noremap = true, silent = true })
-- Go to the root of the git project
vim.api.nvim_set_keymap("n", "<C-g>", ":lua ChangeToGitRoot()<CR>", { noremap = true, silent = true })
-- Git commands
vim.keymap.set("n", "<leader>gweb", "<cmd>Git browse <cr>", { desc = "Navigate to git remote via browser" })
