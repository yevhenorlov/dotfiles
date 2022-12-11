vim.opt.termguicolors = true
-- gruvbox
-- let g:gruvbox_contrast_dark = 'hard'
-- colorscheme gruvbox_customized

-- ayu
vim.g.ayucolor="dark"  -- for light version of theme
-- vim.g.ayuholor="mirage" -- for mirage version of theme
-- vim.g.ayucolor = "light"   -- for dark version of theme
vim.g.yvhn_colorscheme = "ayu"
vim.cmd("colorscheme " .. vim.g.yvhn_colorscheme)
vim.opt.cursorline = true

local is_dark_theme = true
function toggle_theme()
  if is_dark_theme then
    vim.g.ayucolor = "light"
  else
    vim.g.ayucolor = "dark"
  end
  is_dark_theme = not is_dark_theme
  vim.cmd("colorscheme " .. vim.g.yvhn_colorscheme)
end

local is_zen_mode = true
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
    vim.opt.relativenumber = true
  end
  is_zen_mode = not is_zen_mode
end

