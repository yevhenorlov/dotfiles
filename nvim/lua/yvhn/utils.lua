local nnoremap = require("yvhn.keymap").nnoremap
local vnoremap = require("yvhn.keymap").vnoremap

local is_dark_theme = true
function toggle_theme()
  if is_dark_theme then
    vim.g.ayucolor = "light"
    vim.cmd(":set background=light")
  else
    vim.g.ayucolor = "dark"
    vim.cmd(":set background=dark")
  end
  is_dark_theme = not is_dark_theme
  vim.cmd("colorscheme " .. vim.g.yvhn_colorscheme)
end

local is_zen_mode = false
function toggle_zen_mode()
  if is_zen_mode then
    vim.opt.showcmd = false
    vim.opt.laststatus = 0
    vim.opt.number = false
    vim.opt.relativenumber = false
  else
    vim.opt.showcmd = true
    vim.opt.laststatus = 2
    vim.opt.number = true
    vim.opt.relativenumber = false
  end
  is_zen_mode = not is_zen_mode
end

local is_relative_number = false
function toggle_relative_number()
  if is_relative_number then
    vim.opt.relativenumber = false
  else
    vim.opt.relativenumber = true
  end
  is_relative_number = not is_relative_number
end

local is_lsp_on = true
function toggle_lsp()
  if is_lsp_on then
    vim.cmd(":LspStop")
    print(":LspStop") -- TODO figure out why cmd doesn't print automatically
  else
    vim.cmd(":LspStart")
    print(":LspStart")
  end
  is_lsp_on = not is_lsp_on
end

local is_copilot_enabled = true
function toggle_copilot()
  if is_copilot_enabled then
    vim.cmd(":Copilot disable")
    print(":Copilot disable") -- TODO figure out why cmd doesn't print automatically
  else
    vim.cmd(":Copilot enable")
    print(":Copilot enable")
  end
  is_copilot_enabled = not is_copilot_enabled
end

local is_wrap_enabled = false
function toggle_wrap()
  vim.opt.wrap = true
  vim.opt.list = false
  if is_wrap_enabled then
    vim.opt.linebreak = false
    vim.keymap.del('n', 'j')
    vim.keymap.del('n', 'k')
    vim.keymap.del('n', '0')
    vim.keymap.del('n', '^')
    vim.keymap.del('n', '$')
    vim.keymap.del('v', 'j')
    vim.keymap.del('v', 'k')
    vim.keymap.del('v', '0')
    vim.keymap.del('v', '^')
    vim.keymap.del('v', '$')
  else
    vim.opt.linebreak = true
    nnoremap("j", "gj")
    nnoremap("k", "gk")
    nnoremap("0", "g0")
    nnoremap("^", "g^")
    nnoremap("$", "g$")
    vnoremap("j", "gj")
    vnoremap("k", "gk")
    vnoremap("0", "g0")
    vnoremap("^", "g^")
    vnoremap("$", "g$")
  end
  is_wrap_enabled = not is_wrap_enabled
end

