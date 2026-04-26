# env
source $HOME/code/dotfiles/.env
export OPENAI_KEY

# modules
source $HOME/.zshrc_modules/fzf.sh
source $HOME/.zshrc_modules/paths.sh
source $HOME/.zshrc_modules/theme.sh
source $HOME/.zshrc_modules/plugins.sh

# next line disables async-prompt that currently causes git prompt not showing up, hopefully it will be fixed in the future https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#disable-async-git-prompt
zstyle ':omz:alpha:lib:git' async-prompt no

source $ZSH/oh-my-zsh.sh
source $HOME/.zshrc_modules/aliases.sh
source $HOME/.zshrc_modules/settings.sh
source $HOME/.zshrc_modules/tmux.sh


eval "$(fnm env --use-on-cd --shell zsh)"

export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

loadenv() {
  set -o allexport
  source .dev
  set +o allexport
}


export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"

# syntax-highlighting (must be at the end of the file)
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
