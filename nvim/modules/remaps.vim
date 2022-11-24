" reload vim config
nnoremap <Leader><CR> :so $MYVIMRC<CR>

" make current file executable
nnoremap <Leader>x :!chmod +x %<CR>

"call tmux-sessionizer
nnoremap <silent> <C-f> :silent !tmux neww tmux-sessionizer<CR>

" Navigate between buffers
nnoremap <C-h> :bprev<CR>
nnoremap <C-l> :bnext<CR>

" tree exploring
nnoremap <Leader>rr :NERDTreeFind<CR>

"bdo (buffer delete others) - delete all buffers, reopen last one
nmap <Leader>bdo :%bd <bar> e#<CR>
"Shift+b (delete buffer without closing the window) - go to previous buffer, delete the one you just left
nnoremap <silent> <S-b> :bp<BAR>bd#<CR>

" fuzzy search
nnoremap <C-e> :Files<CR>
nnoremap <Leader>e :Files<CR>
nnoremap <C-g> :GFiles<CR>
nnoremap <Leader>p :Rg<CR>
nnoremap <C-p> :Rg<CR>
nnoremap <Leader>bl :Buffers<CR>

" GIT
nnoremap <Leader>gs :G<CR>
nnoremap <Leader>g? :GFiles?<CR>
nnoremap <Leader>gd :Gdiff<CR><C-w><C-w>
nnoremap <Leader>gl :Commits<CR>
"fugitive 3-way merge. //2 and //3 are left and right buffers respectively
nnoremap <Leader>g[ :diffget //2<CR>
nnoremap <Leader>g] :diffget //3<CR>

"toggle status line
let s:hidden_all = 1
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        set nonumber norelativenumber
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
        set number relativenumber
    endif
endfunction
nnoremap <silent> <S-h> :call ToggleHiddenAll()<CR>

" toggle line number/relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
nmap <silent> <Leader>n :call ToggleNumber()<CR>

" Remove search highlights with backspace
nnoremap <silent> <BS> :nohlsearch<CR>

" reset syntax highlighting
nnoremap <Leader>S :syntax sync fromstart<CR>
"
"yank whole file
nnoremap <leader>Y Gygg

"move visual selection up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" next/previous line with same indentation
nnoremap <silent> <C-[> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
nnoremap <silent> <C-]> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>
vnoremap <silent> <C-[> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
vnoremap <silent> <C-]> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>

" move lines up and down
nnoremap <C-j> <CMD>m .+1<CR>
nnoremap <C-k> <CMD>m .-2<CR>

" search without regex by default
nnoremap / /\v

" EasyAlign

" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

