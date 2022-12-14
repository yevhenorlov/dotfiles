local nnoremap = require("yvhn.keymap").nnoremap
local vnoremap = require("yvhn.keymap").vnoremap
local telescope = require("telescope.builtin")

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- toggle color theme
nnoremap("<Leader>t", "<cmd>lua toggle_theme()<CR>")

-- toggle zen mode
nnoremap("<Leader>z", "<cmd>lua toggle_zen_mode()<CR>")

-- toggle relative number
nnoremap("<Leader>n", "<cmd>lua toggle_relative_number()<CR>")

-- reload vim config
nnoremap("<Leader><CR>", "<cmd>so $MYVIMRC<CR>")

-- make current file executable
nnoremap("<Leader>x", "<cmd>!chmod +x %<CR>")

-- call tmux-sessionizer
nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Navigate between buffers
nnoremap("<C-h>", "<cmd>bprev<CR>")
nnoremap("<C-l>", "<cmd>bnext<CR>")

-- tree exploring
nnoremap("<leader>R", "<cmd>Vex<CR>")
nnoremap("<leader>r", "<cmd>NERDTreeFind<CR>")

-- bdo (buffer delete others) - delete all buffers, reopen last one
nnoremap("<Leader>bdo", "<cmd>%bd <bar> e#<CR>")
-- Shift+b (delete buffer without closing the window) - go to previous buffer, delete the one you just left
nnoremap("<S-b>", "<cmd>bp<BAR>bd#<CR>")

-- Telescope search
nnoremap("<leader>ff", telescope.find_files)
nnoremap("<leader>fg", telescope.live_grep)
nnoremap("<leader>fb", telescope.buffers)
nnoremap("<leader>fh", telescope.help_tags)
nnoremap("<leader>fs", telescope.search_history)

-- GIT
nnoremap("<Leader>gs", "<cmd>G<CR>")
nnoremap("<Leader>g?", "<cmd>GFiles?<CR>")
nnoremap("<Leader>gd", "<cmd>Gdiff<CR><C-w><C-w>")
nnoremap("<Leader>gl", "<cmd>Commits<CR>")
-- fugitive 3-way merge. //2 and //3 are left and right buffers respectively
nnoremap("<Leader>g[", "<cmd>diffget //2<CR>")
nnoremap("<Leader>g]", "<cmd>diffget //3<CR>")

-- Remove search highlights with backspace
nnoremap("<BS>", "<cmd>nohlsearch<CR>")

-- reset syntax highlighting
nnoremap("<Leader>S", "<cmd>syntax sync fromstart<CR>")

-- yank whole file
nnoremap("<leader>Y", "Gygg")

-- move visual selection up/down
vnoremap("J", "<cmd>m '>+1<CR>gv=gv")
vnoremap("K", "<cmd>m '<-2<CR>gv=gv")
-- move lines up and down
nnoremap("<C-j>", "<CMD>m .+1<CR>")
nnoremap("<C-k>", "<CMD>m .-2<CR>")

-- search without regex by default
nnoremap("/", "/\\v")

-- TODO ideas
-- sort words in visual selection (line)
-- same-ident jumping navigation 


