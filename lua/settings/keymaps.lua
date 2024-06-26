-- greatest remap ever: primeagen
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

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C---[[ w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Disable LSP
local isLspDiagnosticsVisible = true
vim.keymap.set("n", "<leader>lx", function()
	isLspDiagnosticsVisible = not isLspDiagnosticsVisible
	vim.diagnostic.config({
		virtual_text = isLspDiagnosticsVisible,
		underline = isLspDiagnosticsVisible,
	})
end)
