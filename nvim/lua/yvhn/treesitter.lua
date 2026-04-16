require("nvim-treesitter").setup({
	ensure_installed = {
		"c",
		"html",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"rust",
		"tsx",
		"typescript",
		"vimdoc",
		"vue",
		"ocaml",
	},
	auto_install = true,
})

-- Neovim 0.12+: treesitter highlighting is built-in; enable it per filetype.
-- Fall back to legacy syntax if no parser is available.
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		if not pcall(vim.treesitter.start, args.buf) then
			vim.bo[args.buf].syntax = "on"
		end
	end,
})
