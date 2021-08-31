set nocompatible
filetype plugin on

let maplocalleader="\,"
let mapleader="\<Space>"
set keymap=ukrainian-jcukenmac "insert text in ukrainian by pressing ctrl+^
set iminsert=0 imsearch=0      "default to english
set completeopt=menuone        "always show popup menu for insert mode completion
set mouse=a                    "enable mouse for all modes
set nobackup                   "no backup files
set nowritebackup
set noswapfile                 "no swap files for buffers
set number                     "show number in gutter
set relativenumber             "show line numbers relative to the cursor
set signcolumn=yes             "always show signcolumn (aka gutter)
set title                      "show filename and status in window title
set wrap                       "wrap to new line
set clipboard=unnamed          "use os clipboard
set tabstop=2                  "number of visual spaces per tab
set shiftwidth=2               "when indenting with '>', use 2 spaces width
set expandtab                  "use spaces when pressing tab
set incsearch                  "search as characters are entered
set hlsearch                   "highlight matches
set ignorecase smartcase       "turn on case-insensitive matches (but only when pattern is all-lowercase)
set foldenable                 "enable code folding
set foldmethod=indent
set foldlevelstart=10          "open most folds by default
set foldnestmax=10

" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" exclude filepath from :Rg search (aka fzf.vim aka ctrl-p)
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

