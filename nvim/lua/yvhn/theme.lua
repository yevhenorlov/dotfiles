vim.opt.termguicolors = true

-- ayu
vim.g.ayucolor="dark"  -- for light version of theme
-- vim.g.ayuholor="mirage" -- for mirage version of theme
-- vim.g.ayucolor = "light"   -- for dark version of theme

-- vim.g.yvhn_colorscheme = "ayu"
vim.g.yvhn_colorscheme = "gruvbox_customized"

vim.cmd("colorscheme " .. vim.g.yvhn_colorscheme)
vim.opt.cursorline = true

