local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  "nvim-lua/plenary.nvim", -- async core dependency

  "neovim/nvim-lspconfig",-- Configurations for Nvim LSP
  "jose-elias-alvarez/null-ls.nvim", -- formatting, linting

	{'rose-pine/neovim', as = 'rose-pine'}, -- colorscheme
	"preservim/nerdtree", -- NERDTree - file explorer for vim

  -- code completions (setup in cmp.lua)
  "onsails/lspkind-nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp",

  -- lsp loading status
  "j-hui/fidget.nvim",

  -- TODO rtfm
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",

	-- Sticky headers
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "nvim-treesitter/nvim-treesitter-context",

	"tpope/vim-fugitive", 	-- A Git wrapper so awesome, it should be illegal
	"tpope/vim-commentary",	-- Comment stuff out
	"tpope/vim-surround",	-- Surround words with brackets

  -- neovim-native fuzzy finder
  { 'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Harpoon (persistent project-level markers)
  { "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" } },

	"lukas-reineke/indent-blankline.nvim", 	-- Indent guides
	"editorconfig/editorconfig-vim", -- Generic .editorconfig standard support for Vim
	"junegunn/vim-easy-align", -- A simple, easy-to-use Vim alignment plugin
	"github/copilot.vim", -- Github copilot
})

