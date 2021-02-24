" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" Toggle between buffers
nmap <Leader><Left> <Esc>:bprev<CR>
nmap <Leader><Right> <Esc>:bnext<CR>
nnoremap <C-p> :Rg<CR>
nnoremap <C-e> :Files<CR>
nmap <Leader>bl :Buffers<CR>
"bdo (buffer delete others) - delete all buffers, reopen last one
nmap <Leader>bdo :%bd <bar> e#<CR>

nmap <Leader>g :GFiles<CR>
nmap <Leader>g? :GFiles?<CR>
nmap <Leader>gs :G<CR>
nmap <Leader>gd :Gdiff<CR>
"fugitive 3-way merge. //2 and //3 are left and right buffers respectively
nmap <Leader>g[ :diffget //2<CR>
nmap <Leader>g] :diffget //3<CR>

nmap <Leader>e :Files<CR>
nmap <Leader>p :Rg<CR>
nmap <Leader>H :History<CR>
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

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
nmap <silent> <BS> :nohlsearch<CR>

" reset syntax highlighting
nmap <silent> <Leader>S :syntax sync fromstart<CR>

" move lines up and down
nnoremap <M-j> :m .+1<CR>== 
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" search without regex by default
nnoremap / /\v

" Plugin mappings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

