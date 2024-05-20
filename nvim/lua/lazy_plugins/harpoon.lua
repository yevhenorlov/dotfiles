-- Harpoon (persistent project-level markers)
return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("yvhn.harpoon")
	end,
}
