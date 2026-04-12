-- Collection of various small independent plugins/modules
return {
	"echasnovski/mini.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("yvhn.mini")
	end,
}
