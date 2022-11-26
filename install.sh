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
 : # noop
else
  echo "Config path $ConfigPath does not exist. Creating..."
  mkdir "$ConfigPath"
fi
# check if nvim directory exists
if [[ -d "$ConfigPath/nvim" ]]; then
  : # noop
else 
  echo "Creating nvim directory..."
  mkdir -p "$ConfigPath/nvim"
fi
# check if kitty directory exists
if [[ -d "$ConfigPath/kitty" ]]; then
  : # noop
else 
  echo "Creating kitty directory..."
  mkdir -p "$ConfigPath/kitty"
fi

# zsh
ln -sfn "$DotfilesPath/zsh/.zshrc" "$HOME/.zshrc"
ln -sfn "$DotfilesPath/zsh/.zshrc_modules" "$HOME/.zshrc_modules"
if [[ ! -d "$ZSH_CUSTOM" ]]; then 
  echo "\$ZSH_CUSTOM not found, add symlink manually"
else
  ln -sfn "$DotfilesPath/zsh/themes/lambda_minimal.zsh-theme" "$ZSH_CUSTOM/themes/lambda_minimal.zsh-theme"
fi

# git
ln -sfn "$DotfilesPath/.gitconfig" "$HOME/.gitconfig"
ln -sfn "$DotfilesPath/.gitignore_global" "$HOME/.gitignore_global"

# neovim
ln -sfn "$DotfilesPath/nvim/colors/" "$ConfigPath/nvim/colors"
ln -sfn "$DotfilesPath/nvim/modules/" "$ConfigPath/nvim/modules"
ln -sfn "$DotfilesPath/nvim/keymap/" "$ConfigPath/nvim/keymap"
ln -sfn "$DotfilesPath/nvim/init.vim" "$ConfigPath/nvim/init.vim"

# tmux
ln -sfn "$DotfilesPath/.tmux.conf" "$HOME/.tmux.conf"
ln -sfn "$DotfilesPath/tmux-sessionizer" "/usr/local/bin/tmux-sessionizer"
ln -sfn "$DotfilesPath/tmux-cht.sh" "/usr/local/bin/tmux-cht.sh"

# kitty
ln -sfn "$DotfilesPath/kitty/kitty.conf" "$ConfigPath/kitty/kitty.conf"
ln -sfn "$DotfilesPath/kitty/gruvbox_dark.conf" "$ConfigPath/kitty/gruvbox_dark.conf"
ln -sfn "$DotfilesPath/kitty/gruvbox_dark.conf" "$ConfigPath/kitty/gruvbox_light_soft.conf"
ln -sfn "$DotfilesPath/kitty/ayu.conf" "$ConfigPath/kitty/ayu.conf"

# karabiner
ln -sfn "$DotfilesPath/karabiner/karabiner.json" "$ConfigPath/karabiner/karabiner.json"

# npm stuff
npm install -g prettier tldr
