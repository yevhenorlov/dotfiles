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
"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" toggle line number/relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
nmap <silent> <leader>n :call ToggleNumber()<CR>

" Remove search highlights with backspace
nmap <silent> <BS> :nohlsearch<CR>

" reset syntax highlighting
nmap <silent> <leader>S :syntax sync fromstart<CR>

" move lines up and down (∆ and ˚ here are alt+j and alt+k mac equivalent respectively
nnoremap ∆ :m .+1<CR>== 
nnoremap ˚ :m .-2<CR>==

inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi

vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" search without regex by default
nnoremap / /\v

