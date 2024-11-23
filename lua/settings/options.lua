--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Block cursor
vim.opt.guicursor = ""
vim.opt.termguicolors = true
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
-- Enable mouse mode
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Default browser for MarkdownPreview
vim.g.mkdp_browser = "librewolf"

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Color column
vim.opt.colorcolumn = "80"

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Set the path of netrw to always point to the current dir path
vim.g.netrw_keepdir = 0

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- Adjust indent tabs
vim.o.tabstop = 2

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Undo tree
vim.opt.undofile = true

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.lsp.set_log_level("debug")
