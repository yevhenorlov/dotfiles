-- input
vim.opt.mouse = "a" -- enable mouse for all modes
vim.opt.errorbells = false

-- registers and hidden files
vim.opt.backup = false -- no backup files
vim.opt.writebackup = false
vim.opt.swapfile = false -- no swap files for buffers
vim.opt.clipboard = "unnamedplus" -- use os clipboard

-- formatting
vim.opt.expandtab = true --use spaces when pressing tab
vim.opt.tabstop = 2 --number of visual spaces per tab
vim.opt.shiftwidth = 2 --when indenting with '>', use 2 spaces width
vim.opt.smartindent = true
-- vim.opt.textwidth = 80 -- for gq to work. disable if it affects existing conventions

-- search
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- folds
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 10 -- open most folds by default
vim.opt.foldnestmax = 10
-- save and load folds automatically
-- au BufWinLeave * mkview
-- au BufWinEnter * silent! loadview

vim.opt.signcolumn = "yes" -- always show signcolumn (aka gutter)
vim.opt.title = true -- show filename and status in window title

-- Don't show the mode and the ruler, since they're already in the status line
vim.opt.showmode = false
vim.opt.ruler = false

-- zen mode default state
vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.relativenumber = false

-- fugitive split diffs only vertically
vim.opt.diffopt = "vertical"


-- highlight on yank
vim.cmd[[
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=100 }
augroup END
]]

-- set filetypes as typescriptreact
vim.cmd[[
  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
]]

