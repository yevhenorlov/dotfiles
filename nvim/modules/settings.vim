set nocompatible
filetype plugin on

let maplocalleader="\,"
let mapleader="\<Space>"

" input
set keymap=ukrainian-jcukenmac "insert text in ukrainian by pressing ctrl+^
set iminsert=0 imsearch=0      "default to english

set completeopt=menuone        "always show popup menu for insert mode completion
set mouse=a                    "enable mouse for all modes

" registers and hidden files
set nobackup                   "no backup files
set nowritebackup
set noswapfile                 "no swap files for buffers
set clipboard=unnamed          "use os clipboard

" formatting
set wrap                       "wrap to new line
set expandtab                  "use spaces when pressing tab
set tabstop=2                  "number of visual spaces per tab
set shiftwidth=2               "when indenting with '>', use 2 spaces width
set smartindent

" search
set incsearch                  "search as characters are entered
set hlsearch                   "highlight matches
set ignorecase smartcase       "turn on case-insensitive matches (but only when pattern is all-lowercase)

"TODO folds
set foldenable                 "enable code folding
set foldmethod=manual
set foldlevelstart=10          "open most folds by default
set foldnestmax=10
" save and load folds automatically
" au BufWinLeave * mkview
" au BufWinEnter * silent! loadview

set signcolumn=yes             "always show signcolumn (aka gutter)
set title                      "show filename and status in window title
set statusline=%r%F\%=%{strftime('%Y\%m\%d\.%H\%M')}

" ToggleHiddenAll() default state
set noshowmode                 "no mode indicator
set noruler                    "no line/column number
set laststatus=0
set nonumber norelativenumber


"higlight on yank (`:h lua-highlight` for details)
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=100 }
augroup END

" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" exclude filepath from :Rg search (aka ripgrep aka fzf.vim aka ctrl-p)
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

