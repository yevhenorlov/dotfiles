-- TODO move all to respective modules
local nnoremap = require("yvhn.keymap").nnoremap

-- navigate diagnostics
nnoremap("]d", vim.diagnostic.goto_next)
nnoremap("[d", vim.diagnostic.goto_prev)

-- toggle relative number
nnoremap("<Leader>tn", "<cmd>lua toggle_relative_number()<CR>")

-- toggle wrap
nnoremap("<Leader>tw", "<cmd>lua toggle_wrap()<CR>")

-- toggle zen mode
nnoremap("<Leader>tz", "<cmd>lua toggle_zen_mode()<CR>")
-- toggle copilot

nnoremap("<Leader>tc", "<cmd>lua toggle_copilot()<CR>")
nnoremap("<Leader>cs", "<cmd>:Copilot status<CR>")

-- toggle lsp
nnoremap("<Leader>L", "<cmd>lua toggle_lsp()<CR>")

-- toggle zoom (tmux-like)
nnoremap("<Leader>zi", "<cmd>:tab split<CR>")
nnoremap("<Leader>zo", "<cmd>:tab close<CR>")

-- less dizzy navigation
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- call tmux-sessionizer
nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- bdo (buffer delete others) - delete all buffers, reopen last one
nnoremap("<Leader>bdo", "<cmd>%bd <bar> e#<CR>")
-- Shift+b (delete buffer without closing the window) - go to previous buffer, delete the one you just left
nnoremap("<S-b>", "<cmd>bp<BAR>bd#<CR>")

-- Remove search highlights with backspace
nnoremap("<BS>", "<cmd>nohlsearch<CR>")

-- reset syntax highlighting
nnoremap("<Leader>S", "<cmd>syntax sync fromstart<CR>")

-- yank whole file
nnoremap("<leader>Y", "Gygg")

-- -- move line up/down (only in insert mode)
-- inoremap("<C-j>", "<CMD>m .+1<CR>")
-- inoremap("<C-k>", "<CMD>m .-2<CR>")

-- search without regex by default
nnoremap("/", "/\\v")

-- substitute word under cursor
nnoremap("<Leader>s", ":%s/<C-r><C-w>//g<left><left>")

-- TODO ideas
-- sort words in visual selection (line)
-- same-ident jumping navigation
