syntax on
color dracula
filetype plugin on
set omnifunc=syntaxcomplete#Completeset smartindent " use omnicompletion
set clipboard=unnamed    " use os clipboard
set tabstop=2            " number of visual spaces per tab
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

packadd! matchit         " add matchit plugin
let g:NERDTreeWinSize=50 " NERDTree default width
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
" Mappings
"============================================================
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
map <C-b> :NERDTreeToggle<CR>
nmap <silent>  <BS>  :nohlsearch<CR>
nmap <Left> :tabprevious<CR>
nmap <Right> :tabnext<CR>
nmap <Up> <Esc>:bprev<CR>
nmap <Down> <Esc>:bnext<CR>
nnoremap / /\v

execute pathogen#infect()
call pathogen#helptags()
