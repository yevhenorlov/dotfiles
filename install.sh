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
ln -sfn "$DotfilesPath/nvim/lua/" "$ConfigPath/nvim/lua"
ln -sfn "$DotfilesPath/nvim/init.lua" "$ConfigPath/nvim/init.lua"

# tmux
ln -sfn "$DotfilesPath/.tmux.conf" "$HOME/.tmux.conf"
ln -sfn "$DotfilesPath/tmux-sessionizer" "/usr/local/bin/tmux-sessionizer"
ln -sfn "$DotfilesPath/tmux-cht.sh" "/usr/local/bin/tmux-cht.sh"

# karabiner
ln -sfn "$DotfilesPath/karabiner/karabiner.json" "$ConfigPath/karabiner/karabiner.json"

# npm dependencies that were not handled by mason.nvim etc.
# to update the list, check
# npm list -g --depth 0
npm install -g prettier tldr typescript @vue/language-server

# for faster search from Telescope.nvim
brew install ripgrep
