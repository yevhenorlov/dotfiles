# dotfiles

🌐 dotfiles &amp; global configs

![screenshot](screenshot.png)

## Software

1. Terminal - [kitty](https://sw.kovidgoyal.net/kitty/)
1. Shell - [oh-my-zsh](https://ohmyz.sh/)
1. Code editor - [neovim](https://github.com/neovim/neovim/) with a [custom theme](./nvim/colors/gruvbox_customized.vim) based on [Gruvbox](https://github.com/morhetz/gruvbox)
1. Font - [Dank mono](http://dank.sh)
1. Neat terminal plugins:

- [pomodoro](https://github.com/carlmjohnson/pomodoro)

## Installation

### [install `neovim`](https://github.com/neovim/neovim/wiki/Installing-Neovim):

```sh
brew install neovim
```

### [install `kitty`](https://sw.kovidgoyal.net/kitty/binary/):

```sh
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

### clone repo to `~/code`

```sh
git clone git@github.com:yevhenorlov/dotfiles.git ~/code/dotfiles
```

### add symlinks to pick up resources from dotfiles repo

```sh
cd ~/code/dotfiles
./install.sh
```

### install ripgrep (for fzf to work with it)

```sh
brew install rg
```
