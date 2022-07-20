" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" Open current buffer in NERDTree
nmap <leader>r :NERDTreeFind<CR>

" fix gx command (issue: https://github.com/vim/vim/issues/4738)
nmap <silent> gx :!open <cfile><cr>

" Toggle between buffers
nnoremap <C-h> :bprev<CR>
nnoremap <C-l> :bnext<CR>

nnoremap <C-p> :Rg<CR>
nnoremap <C-e> :Files<CR>
nmap <Leader>bl :Buffers<CR>
"bdo (buffer delete others) - delete all buffers, reopen last one
nmap <Leader>bdo :%bd <bar> e#<CR>
"Shift+b (delete buffer without closing the window) - go to previous buffer, delete the one you just left
nnoremap <silent> <S-b> :bp<BAR>bd#<CR>

" GIT
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
nmap <silent> <BS> :nohlsearch<CR>

" reset syntax highlighting
nmap <Leader>S :syntax sync fromstart<CR>

" next/previous line with same indentation
nnoremap <silent> <C-[> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
nnoremap <silent> <C-]> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>

" move lines up and down
nnoremap <C-j> <CMD>m .+1<CR>
nnoremap <C-k> <CMD>m .-2<CR>

" search without regex by default
nnoremap / /\v

" Plugin mappings

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

