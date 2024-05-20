require("oil").setup({
	view_options = {
		-- Show files and directories that start with "."
		show_hidden = true,
	},
})

local nnoremap = require("yvhn.keymap").nnoremap
nnoremap("-", vim.cmd.Oil, { desc = "Open parent directory" })
nnoremap("<leader>-", require("oil").toggle_float)
