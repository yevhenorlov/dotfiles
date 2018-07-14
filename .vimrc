" sources for inspiration: 
"   'Mastering Vim' by Damian Conway
"   https://github.com/noopkat/dotfiles/blob/master/.vimrc
"   https://dougblack.io/words/a-good-vimrc.html

" general settings {{{
" This must be first, because it changes other options as side effect
set nocompatible
filetype plugin on

syntax on
color dracula

set encoding=utf8
set keymap=ukrainian-jcukenmac " insert text in ukrainian by pressing ctrl+^
set iminsert=0 imsearch=0   " english by default
set omnifunc=syntaxcomplete#Completeset smartindent " use omnicompletion
set clipboard=unnamed    " use os clipboard
set tabstop=2            " number of visual spaces per tab
set shiftwidth=2         " when indenting with '>', use 2 spaces width
set tw=80                " set word wrap to 80 characters
set softtabstop=2        " number of spaces in tab when editing
set expandtab            " tab to spaces
set backspace=2          " set backspace to work as usual
set relativenumber       " show line numbers relative to the cursor
set cursorline           " highlight current line
set showmatch            " highlight matching [{()}]
set incsearch            " search as characters are entered
set hlsearch             " highlight matches
set ignorecase smartcase " turn on case-insensitive matches (but only when pattern is all-lowercase)
set wildmenu             " visual autocomplete for command menu
set foldenable           " enable code folding
set foldmethod=indent
set foldlevelstart=10    " open most folds by default
set foldnestmax=10
set noswapfile           " don't create a swap file
set autoread             " automatically update changed files
set hidden               " hide buffer with unsaved changes instead of closing it
set noeb vb t_vb=        " don't beep
set termguicolors        " use termguicolors
set laststatus=2         " always show statusline
set ttimeoutlen=50       " reduce statusline delay after switching modes
set path+=**             " search down recursively
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*

packadd! matchit         " add matchit plugin

let g:NERDTreeWinSize=50 " NERDTree default width
let g:NERDTreeShowHidden=1 " NERDTree display hidden files by default
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " autoquit if only nerdtree is open

let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_show_hidden=1
" }}}
" help {{{
" Make :help appear in a full-screen tab, instead of a window 
"only apply to .txt files
augroup HelpInTabs
  autocmd!
  autocmd BufEnter  *.txt   call HelpInNewTab()
augroup END
"only apply to help files
function! HelpInNewTab ()
  if &buftype == 'help'
    "convert the help window to a tab
    execute "normal \<C-W>T"
  endif
endfunction
" }}}
" emmet {{{

let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}
" }}}
" lightline {{{

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
" }}}
" prettier {{{

" set the prettier CLI executable path
let g:prettier#exec_cmd_path = "/usr/local/bin/prettier"

" max line length that prettier will wrap on
" Prettier default: 80
let g:prettier#config#print_width = 80

" number of spaces per indentation level
" Prettier default: 2
let g:prettier#config#tab_width = 2

" use tabs over spaces
" Prettier default: false
let g:prettier#config#use_tabs = 'false'

" print semicolons
" Prettier default: true
let g:prettier#config#semi = 'false'

" single quotes over double quotes
" Prettier default: false
let g:prettier#config#single_quote = 'true'

" print spaces between brackets
" Prettier default: true
let g:prettier#config#bracket_spacing = 'true'

" put > on the last line instead of new line
" Prettier default: false
let g:prettier#config#jsx_bracket_same_line = 'false'

" avoid|always
" Prettier default: avoid
let g:prettier#config#arrow_parens = 'avoid'

" none|es5|all
" Prettier default: none
let g:prettier#config#trailing_comma = 'none'

" flow|babylon|typescript|css|less|scss|json|graphql|markdown
" Prettier default: babylon
let g:prettier#config#parser = 'babylon'

" cli-override|file-override|prefer-file
let g:prettier#config#config_precedence = 'prefer-file'

" always|never|preserve
let g:prettier#config#prose_wrap = 'preserve'
" }}}
" ale {{{

let g:ale_linters = {'javascript': ['eslint']}
" }}}
" mappings {{{

" change the mapleader from \ to ,
let mapleader=","

" toggle line number/relativenumber
nmap <silent> <leader>n :call ToggleNumber()<CR>

" quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" ctrl-p plugin shortcut
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" nerd tree toggling
map <C-b> :NERDTreeToggle<CR>

" remove search highlights with backspace
nmap <silent>  <BS>  :nohlsearch<CR>

" reset syntax highlighting
nmap <silent> <leader>s :syntax sync fromstart<CR>

" buffer navigation
nmap <Left> <Esc>:bprev<CR>
nmap <Right> <Esc>:bnext<CR>

" move lines up and down
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" search without regex by default
nnoremap / /\v
" }}}
" custom functions {{{
" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
" }}}
" pathogen config {{{
execute pathogen#infect()
call pathogen#helptags()
" }}}
" modelines {{{
set modelines=2
" vim:foldmethod=marker:foldlevel=0 
" }}}
