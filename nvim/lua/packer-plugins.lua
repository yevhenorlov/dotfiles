-- TODO finish migration from coc
return require("packer").startup(function(use)
	-- packer can manage itself
	use("wbthomason/packer.nvim")
	-- colorscheme
	use("ayu-theme/ayu-vim")
	-- NERDTree - file explorer for vim
	use("preservim/nerdtree")

	-- Sticky headers
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate"
	}
	-- TODO "nvim-treesitter/nvim-treesitter-context"

	-- A Git wrapper so awesome, it should be illegal
	use("tpope/vim-fugitive")

	-- Comment stuff out
	use("tpope/vim-commentary")

	-- A simple, easy-to-use Vim alignment plugin
	-- "junegunn/vim-easy-align"

	-- fzf is a general-purpose command-line fuzzy finder
	use {"junegunn/fzf", run = ":call fzf#install()" }
	use("junegunn/fzf.vim")

	-- Indent guides
	use("lukas-reineke/indent-blankline.nvim")

	-- Generic .editorconfig standard support for Vim
	-- use("editorconfig/editorconfig-vim")

	-- "syntax highlighting
	-- Plug "leafgarland/typescript-vim"
	-- Plug "peitalin/vim-jsx-typescript"
	-- Plug "evanleck/vim-svelte", {"branch": "main"}
	-- Plug "godlygeek/tabular"
	-- Plug "preservim/vim-markdown"

	-- "Clojure tooling
	-- Plug "Olical/conjure", {"tag": "v4.17.0"}
	-- Plug "venantius/vim-cljfmt"


	-- ""Twitter
	-- "Plug "https://github.com/twitvim/twitvim.git"
end
)
