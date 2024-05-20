-- A Git wrapper so awesome, it should be illegal
return {
	"tpope/vim-fugitive",
	config = function()
		require("yvhn.fugitive")
	end,
}
