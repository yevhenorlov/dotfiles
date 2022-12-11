vim.opt.undofile = true -- Maintain undo history between sessions
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")

-- Persist cursor
vim.cmd[[
autocmd BufReadPost *
\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
\ |   exe "normal! g`\""
\ | endif
]]
