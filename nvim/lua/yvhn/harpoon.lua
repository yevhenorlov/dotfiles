local harpoon = require("harpoon")

harpoon.setup()

-- TODO move to remaps.lua vvvvvvvvv

vim.keymap.set("n", "<Leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<Leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "Q", function() harpoon:list():prev() end)
vim.keymap.set("n", "W", function() harpoon:list():next() end)
