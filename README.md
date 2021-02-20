# dotfiles
🌐 dotfiles &amp; global configs


Software:
1. [Alacritty](https://github.com/alacritty/alacritty) with [Gruvbox](https://github.com/morhetz/gruvbox) theme and [Dank mono](http://dank.sh) font.
2. Terminal plugins:
+ [tmux](https://github.com/tmux/tmux)
+ [pomodoro](https://github.com/carlmjohnson/pomodoro)
+ [slack-term](https://github.com/erroneousboat/slack-term)
3. Vim plugins (old, rewrite):
+ [ChucK](https://github.com/wilsaj/chuck.vim)
+ [Ctrl-P](https://github.com/kien/ctrlp.vim)
+ [Dracula theme](https://github.com/dracula/vim)
+ [Emmet-vim](https://github.com/mattn/emmet-vim)
+ [fugitive](https://github.com/tpope/vim-fugitive)
+ [NerdTree](https://github.com/scrooloose/nerdtree)
+ [NrrwRgn](https://github.com/chrisbra/NrrwRgn)
+ [Prettier](https://github.com/prettier/vim-prettier)
+ [vim-airline](https://github.com/vim-airline/vim-airline)
+ [vim-javascript](https://github.com/pangloss/vim-javascript.git)
+ [vim-mutiple-cursors](https://github.com/terryma/vim-multiple-cursors)
+ [vim-surround](https://github.com/tpope/vim-surround)
+ [vimproc](https://github.com/Shougo/vimproc.vim)
+ [YouCompleteMe](https://github.com/valloric/youcompleteme)

# Steps (draft)

1. clone repo to ~/code;

2. add respective symlinks to pick up resources from dotfiles repo

## Alacritty

```sh
# under ~/.config/alacritty

$ ln -s ~/code/dotfiles/alacritty/alacritty.yml alacritty.yml
```

## Neovim

```sh
# under ~/.config/nvim

$ ln -s ~/code/dotfiles/nvim/init.vim ./init.vim
$ ln -s ~/code/dotfiles/nvim/modules ./modules
```

## install ripgrep (for fzf to work with it):

```brew install rg
