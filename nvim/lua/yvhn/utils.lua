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
    vim.opt.showmode = false 
    vim.opt.ruler = false 
    vim.opt.laststatus = 0
    vim.opt.number = false
    vim.opt.relativenumber = false
  else
    vim.opt.showcmd = true
    vim.opt.showmode = true 
    vim.opt.ruler = true 
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
