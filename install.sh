#!/bin/bash

# variables
DotfilesPath="$HOME/code/dotfiles"
ConfigPath="$HOME/.config"

if [[ -d "$DotfilesPath" ]]; then 
  : # noop
else
  echo "ERROR: $DotfilesPath does not exist. Make sure you've cloned dotfiles correctly: https://github.com/yevhenorlov/dotfiles#installation"
  exit
fi

if [[ -d "$ConfigPath" ]]; then 
 : 
else
  echo "Config path $ConfigPath does not exist. Creating..."
  # check if nvim directory exists
  if [[ -d "$ConfigPath/nvim" ]]; then
    :
    else 
      echo "Creating nvim directory..."
      mkdir -p "$ConfigPath/nvim"
  fi
  # check if kitty directory exists
  if [[ -d "$ConfigPath/kitty" ]]; then
    :
    else 
      echo "Creating kitty directory..."
      mkdir -p "$ConfigPath/kitty"
  fi
fi

# zsh
ln -sfn "$DotfilesPath/.zshrc" "$ConfigPath/.zshrc"
ln -sfn "$DotfilesPath/.zshrc_modules" "$ConfigPath/.zshrc_modules"

# git
ln -sfn "$DotfilesPath/.gitconfig" "$ConfigPath/.gitconfig"
ln -sfn "$DotfilesPath/.gitignore_global" "$ConfigPath/.gitignore_global"

# neovim
ln -sfn "$DotfilesPath/nvim/colors/" "$ConfigPath/nvim/colors"
ln -sfn "$DotfilesPath/nvim/modules/" "$ConfigPath/nvim/modules"
ln -sfn "$DotfilesPath/nvim/keymap/" "$ConfigPath/nvim/keymap"
ln -sfn "$DotfilesPath/nvim/init.vim" "$ConfigPath/nvim/init.vim"

# kitty
ln -sfn "$DotfilesPath/kitty/kitty.conf" "$ConfigPath/kitty/kitty.conf"
ln -sfn "$DotfilesPath/kitty/gruvbox_dark.conf" "$ConfigPath/kitty/gruvbox_dark.conf"
