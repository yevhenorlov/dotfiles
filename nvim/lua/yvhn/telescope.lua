local nnoremap = require("yvhn.keymap").nnoremap
local builtin = require("telescope.builtin")

require("telescope").setup({
	pickers = {
		live_grep = {
			additional_args = function(opts)
				return { "--no-ignore", "--hidden", "--glob", "!.git", "--glob", "!node_modules" }
			end,
		},
	},
})

-- Telescope search
nnoremap("<leader>ff", builtin.git_files)
nnoremap("<leader>fg", builtin.live_grep)
nnoremap("<leader>fb", builtin.buffers)
nnoremap("<leader>fh", builtin.help_tags)
nnoremap("<leader>fs", builtin.search_history)
nnoremap("<leader>f/", builtin.current_buffer_fuzzy_find)
