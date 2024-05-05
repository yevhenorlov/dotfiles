local nnoremap = require("yvhn.keymap").nnoremap
local vnoremap = require("yvhn.keymap").vnoremap
local inoremap = require("yvhn.keymap").inoremap
local telescope = require("telescope.builtin")

-- toggle relative number
nnoremap("<Leader>tn", "<cmd>lua toggle_relative_number()<CR>")

-- toggle color theme
nnoremap("<Leader>tt", "<cmd>lua toggle_theme()<CR>")

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

-- reload vim config
nnoremap("<Leader><CR>", "<cmd>so $MYVIMRC<CR>")

-- make current file executable
nnoremap("<Leader>x", "<cmd>!chmod +x %<CR>")

-- call tmux-sessionizer
nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- tree exploring
nnoremap("<leader>R", "<cmd>Vex<CR>")
nnoremap("<leader>r", "<cmd>NERDTreeFind<CR>")

-- bdo (buffer delete others) - delete all buffers, reopen last one
nnoremap("<Leader>bdo", "<cmd>%bd <bar> e#<CR>")
-- Shift+b (delete buffer without closing the window) - go to previous buffer, delete the one you just left
nnoremap("<S-b>", "<cmd>bp<BAR>bd#<CR>")

-- Telescope search
nnoremap("<leader>ff", telescope.git_files)
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

-- move line up/down (only in insert mode)
inoremap("<C-j>", "<CMD>m .+1<CR>")
inoremap("<C-k>", "<CMD>m .-2<CR>")

-- search without regex by default
nnoremap("/", "/\\v")

-- substitute word under cursor
nnoremap("<Leader>s", ":%s/<C-r><C-w>//g<left><left>")

-- TODO ideas
-- sort words in visual selection (line)
-- same-ident jumping navigation 

