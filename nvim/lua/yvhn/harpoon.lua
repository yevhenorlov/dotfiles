local nnoremap = require("yvhn.keymap").nnoremap
local harpoon = require("harpoon")

harpoon.setup()

nnoremap("<Leader>a", function()
	harpoon:list():add()
end)
nnoremap("<Leader>e", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

nnoremap("<C-h>", function()
	harpoon:list():select(1)
end)
nnoremap("<C-j>", function()
	harpoon:list():select(2)
end)
nnoremap("<C-k>", function()
	harpoon:list():select(3)
end)
nnoremap("<C-l>", function()
	harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
nnoremap("Q", function()
	harpoon:list():prev()
end)
nnoremap("W", function()
	harpoon:list():next()
end)
