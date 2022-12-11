-- input
vim.opt.completeopt = "menuone" -- always show popup menu for insert mode completion
vim.opt.mouse = "a" -- enable mouse for all modes
vim.opt.errorbells = false

-- registers and hidden files
vim.opt.backup = false -- no backup files
vim.opt.writebackup = false
vim.opt.swapfile = false -- no swap files for buffers
vim.opt.clipboard = "unnamed" -- use os clipboard

-- formatting
vim.opt.wrap = true --wrap to new line
vim.opt.expandtab = true --use spaces when pressing tab
vim.opt.tabstop = 2 --number of visual spaces per tab
vim.opt.shiftwidth = 2 --when indenting with '>', use 2 spaces width
vim.opt.smartindent = true

-- search
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

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

-- ToggleHiddenAll() default state
vim.opt.showmode = false -- no mode indicator
vim.opt.ruler = false -- no line/column number
vim.opt.laststatus = 0
vim.opt.number = false
vim.opt.relativenumber = false

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

-- exclude filepath from :Rg search (aka ripgrep aka fzf.vim aka ctrl-p)
vim.cmd[[
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
]]
