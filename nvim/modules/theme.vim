set termguicolors
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox_customized
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
