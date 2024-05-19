-- file explorer
return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	config = function()
		require("yvhn.oil")
	end,
}
