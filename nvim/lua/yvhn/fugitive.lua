local nnoremap = require("yvhn.keymap").nnoremap

nnoremap("<Leader>gs", "<cmd>G<CR>")
nnoremap("<Leader>gd", "<cmd>Gdiff<CR><C-w><C-w>")
-- fugitive 3-way merge. //2 and //3 are left and right buffers respectively
nnoremap("<Leader>g[", "<cmd>diffget //2<CR>")
nnoremap("<Leader>g]", "<cmd>diffget //3<CR>")
