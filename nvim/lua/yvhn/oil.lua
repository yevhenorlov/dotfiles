require("oil").setup({
	view_options = {
		-- Show files and directories that start with "."
		show_hidden = true,
	},
})

local nnoremap = require("yvhn.keymap").nnoremap
nnoremap("-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
