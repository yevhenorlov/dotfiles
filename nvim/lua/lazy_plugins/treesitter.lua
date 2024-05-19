return {
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		require("yvhn.treesitter")
	end,
}
