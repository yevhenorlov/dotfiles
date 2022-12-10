set termguicolors
" gruvbox
" let g:gruvbox_contrast_dark = 'hard'
" colorscheme gruvbox_customized

" ayu
" let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
colorscheme ayu
syntax on

set cursorline
set hidden
set cmdheight=1
set laststatus=2

"toggle colorscheme
let s:is_dark_colorscheme = 1
function! ToggleColorScheme()
    if s:is_dark_colorscheme  == 0
        let s:is_dark_colorscheme = 1
        set background=dark
    else
        let s:is_dark_colorscheme = 0
        set background=light
    endif
endfunction
nnoremap <silent> <Leader>t :call ToggleColorScheme()<CR>
