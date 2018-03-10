syntax on
color dracula

filetype plugin on
set omnifunc=syntaxcomplete#Completeset smartindent " use omnicompletion
set clipboard=unnamed    " use os clipboard
set tabstop=2            " number of visual spaces per tab
set shiftwidth=2         " when indenting with '>', use 2 spaces width
set tw=80                " set word wrap to 80 characters
set softtabstop=2        " number of spaces in tab when editing
set expandtab            " tab to spaces
set backspace=2          " set backspace to work as usual
set number               " show line numbers
set cursorline           " highlight current line
set showmatch            " highlight matching [{()}]
set incsearch            " search as characters are entered
set hlsearch             " highlight matches
set ignorecase smartcase " turn on case-insensitive matches (but only when pattern is all-lowercase)
set noswapfile           " don't create a swap file
set autoread             " automatically update changed files

packadd! matchit         " add matchit plugin

let g:NERDTreeWinSize=50 " NERDTree default width
let g:NERDTreeShowHidden=1 " NERDTree display hidden files by default
let g:ctrlp_working_path_mode = 'r'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*
let g:ctrlp_show_hidden=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " autoquit if only nerdtree is open

"============================================================
" Make :help appear in a full-screen tab, instead of a window
"============================================================
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

"============================================================
" airline config
"============================================================

let g:airline_theme = 'wombat'
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline_left_sep = ' ★  '
let g:airline_right_sep = ' 🟆  '
let g:airline_section_warning = ''
let g:airline_section_y = ''
let g:airline_section_x = ''
set laststatus=2 " for airline

"============================================================
" Mappings
"============================================================

" ctrl-p plugin shortcut
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" nerd tree toggling
map <C-b> :NERDTreeToggle<CR>

" remove search highlights with backspace
nmap <silent>  <BS>  :nohlsearch<CR>

" buffer navigation
nmap <Left> <Esc>:bprev<CR>
nmap <Right> <Esc>:bnext<CR>

" search without regex by default
nnoremap / /\v

"============================================================
" Start pathogen
"============================================================

execute pathogen#infect()
call pathogen#helptags()
