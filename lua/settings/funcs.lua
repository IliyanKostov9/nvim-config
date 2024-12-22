local funcs = {}

function funcs.better_escape_vim()
  vim.api.nvim_input("<Esc>")
  local current_line = vim.api.nvim_get_current_line()
  if current_line:match("^%s+$") then
    vim.api.nvim_set_current_line("")
  end
end

function funcs.cd_to_git_root()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

  if git_root == nil or git_root == "" then
    print("Not in a Git repository")
  else
    vim.cmd("Explore" .. vim.fn.fnameescape(git_root))
  end
end

function funcs.change_line_number()
  local is_relative_number_enabled = vim.wo.relativenumber
  vim.wo.relativenumber = not is_relative_number_enabled
end

local is_lsp_diagnostics_visible = true
function funcs.disable_lsp()
  is_lsp_diagnostics_visible = not is_lsp_diagnostics_visible

  vim.diagnostic.config {
    virtual_text = is_lsp_diagnostics_visible,
    underline = is_lsp_diagnostics_visible,
  }
end

local function set_alacritty_theme(color_theme_hex, theme_name)
  local nixos_path = "/etc/nixos"
  local tmux_status_bar_color = vim.fn.system("tmux show-options -g status-style")
  local bg_color = tmux_status_bar_color:match("bg#?=([#%x]+)")

  if bg_color ~= color_theme_hex then
    print("Changing Nix alacritty theme to:", theme_name)
    vim.fn.chdir(nixos_path)
    vim.fn.system("make home-update")
  end
end

function funcs.schedule_color_scheme(light_color_theme, dark_color_theme, light_color_theme_hex, dark_color_theme_hex)
  local current_hour = tonumber(os.date("%H"))

  local morning_hour = 7
  local evening_hour = 16

  if current_hour >= morning_hour and current_hour < evening_hour then
    vim.cmd.colorscheme(light_color_theme)
    set_alacritty_theme(light_color_theme_hex, light_color_theme)
  else
    vim.cmd.colorscheme(dark_color_theme)
    set_alacritty_theme(dark_color_theme_hex, dark_color_theme)
  end
end

return funcs
