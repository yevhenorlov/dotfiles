-- TODO move all to respective modules
local nnoremap = require("yvhn.keymap").nnoremap
local vnoremap = require("yvhn.keymap").vnoremap

-- restart lsp
nnoremap("<Leader>L", function()
	print("Restarting LSP servers...")
	vim.cmd.LspRestart()
end)

-- call tmux-sessionizer
nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- navigate diagnostics
nnoremap("]d", vim.diagnostic.goto_next)
nnoremap("[d", vim.diagnostic.goto_prev)

-- toggle zoom (tmux-like)
nnoremap("<Leader>zi", "<cmd>:tab split<CR>")
nnoremap("<Leader>zo", "<cmd>:tab close<CR>")

-- less dizzy navigation
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

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
-- meta keys and mac usually don't play well together ( because of alt/option shenanigans), this is working because of the `macos_option_as_alt` setting enabled in kitty.conf
nnoremap("<M-j>", "<CMD>m .+1<CR>")
nnoremap("<M-k>", "<CMD>m .-2<CR>")
vnoremap("<M-j>", "<CMD>m .+1<CR>")
vnoremap("<M-k>", "<CMD>m .-2<CR>")

-- search without regex by default
nnoremap("/", "/\\v")

-- substitute word under cursor
nnoremap("<Leader>s", ":%s/<C-r><C-w>//g<left><left>")

-- TODO ideas
-- sort words in visual selection (line)
-- same-ident jumping navigation
