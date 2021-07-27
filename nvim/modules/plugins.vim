call plug#begin()

  "NERDTree - file explorer for vim
  Plug 'preservim/nerdtree'

  "A Git wrapper so awesome, it should be illegal
  Plug 'tpope/vim-fugitive'

  "Generic .editorconfig standard support for Vim
  Plug 'editorconfig/editorconfig-vim'

  "A light and configurable statusline/tabline plugin for Vim
  Plug 'itchyny/lightline.vim'

  "Nicer, clickable buffer tabs
  Plug 'mengelbrecht/lightline-bufferline'

  "A simple, easy-to-use Vim alignment plugin
  Plug 'junegunn/vim-easy-align'

  "fzf is a general-purpose command-line fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  "Gruvbox colorscheme
  Plug 'lifepillar/vim-gruvbox8'
  "256-noir colorscheme
  Plug 'andreasvc/vim-256noir'

  "Nodejs extension host for vim & neovim, load extensions like VSCode and host language servers
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  "Comment stuff out
  Plug 'tpope/vim-commentary'

  "JSX, TSX, Nunjucks syntax highlighting
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
	Plug 'lepture/vim-jinja'

	"Clojure tooling
	Plug 'Olical/conjure', {'tag': 'v4.17.0'}

	"Twitter
	Plug 'https://github.com/twitvim/twitvim.git'
call plug#end()
