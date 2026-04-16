return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		event = "BufReadPre",
		config = function()
			require("yvhn.treesitter")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		config = function()
			require("treesitter-context").setup({
				enable = true,
				max_lines = 0,
				trim_scope = "outer",
				zindex = 20,
				mode = "cursor",
				separator = nil,
			})
		end,
	},
}
