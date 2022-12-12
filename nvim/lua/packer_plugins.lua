return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")	-- packer can manage itself
  use("neovim/nvim-lspconfig")-- Configurations for Nvim LSP
	use("ayu-theme/ayu-vim") -- colorscheme
	use("preservim/nerdtree") -- NERDTree - file explorer for vim

  -- code completions (setup in cmp.lua)
  use("onsails/lspkind-nvim")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-nvim-lsp")

  -- lsp loading status
  use("j-hui/fidget.nvim")

  -- TODO rtfm
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")

	-- Sticky headers
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use("nvim-treesitter/nvim-treesitter-context")

	use("tpope/vim-fugitive") 	-- A Git wrapper so awesome, it should be illegal
	use("tpope/vim-commentary")	-- Comment stuff out


	-- fzf is a general-purpose command-line fuzzy finder
	use {"junegunn/fzf", run = ":call fzf#install()" }
	use("junegunn/fzf.vim")

	use("lukas-reineke/indent-blankline.nvim") 	-- Indent guides
	use("editorconfig/editorconfig-vim") -- Generic .editorconfig standard support for Vim
	use("junegunn/vim-easy-align") -- A simple, easy-to-use Vim alignment plugin

  -- TODO to checkout:
  -- Telescope (better Rg?) https://github.com/nvim-telescope/telescope.nvim
  -- Harpoon (persistent project-level markers) https://github.com/ThePrimeagen/harpoon
  -- Lua Gruvbox (might be easier to hack+support than the current gruvbox_customized.vim) https://github.com/ellisonleao/gruvbox.nvim

  --[[
	"syntax highlighting
	Plug "leafgarland/typescript-vim"
	Plug "peitalin/vim-jsx-typescript"
	Plug "evanleck/vim-svelte", {"branch": "main"}
	Plug "godlygeek/tabular"
	Plug "preservim/vim-markdown"

	"Clojure tooling
	Plug "Olical/conjure", {"tag": "v4.17.0"}
	Plug "venantius/vim-cljfmt"
	""Twitter
	"Plug "https://github.com/twitvim/twitvim.git"
  --]]
end
)
