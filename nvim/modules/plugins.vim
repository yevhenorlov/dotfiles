call plug#begin()

  "NERDTree - file explorer for vim
  Plug 'preservim/nerdtree'

  "A Git wrapper so awesome, it should be illegal
  Plug 'tpope/vim-fugitive'

  "Comment stuff out
  Plug 'tpope/vim-commentary'

  "A light and configurable statusline/tabline plugin for Vim
  " Plug 'itchyny/lightline.vim'

  "Nicer, clickable buffer tabs
  " Plug 'mengelbrecht/lightline-bufferline'

  "A simple, easy-to-use Vim alignment plugin
  Plug 'junegunn/vim-easy-align'

  "fzf is a general-purpose command-line fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  "Gruvbox colorscheme 
  "(UPD: replaced by colors/gruvbox_customized.vim)
  " Plug 'morhetz/gruvbox'

  " Indent guides
  Plug 'lukas-reineke/indent-blankline.nvim'

  "Nodejs extension host for vim & neovim, load extensions like VSCode and host language servers
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  "Generic .editorconfig standard support for Vim
  Plug 'editorconfig/editorconfig-vim'

  "syntax highlighting
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'evanleck/vim-svelte', {'branch': 'main'}
  Plug 'preservim/vim-markdown'
  "Clojure tooling
  Plug 'Olical/conjure', {'tag': 'v4.17.0'}
  Plug 'venantius/vim-cljfmt'


  ""Twitter
  "Plug 'https://github.com/twitvim/twitvim.git'
call plug#end()
