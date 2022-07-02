# modules
source $HOME/.zshrc_modules/fzf.sh
# source $HOME/.zshrc_modules/tmux.sh
source $HOME/.zshrc_modules/paths.sh
source $HOME/.zshrc_modules/theme.sh
source $HOME/.zshrc_modules/plugins.sh
source $ZSH/oh-my-zsh.sh
source $HOME/.zshrc_modules/aliases.sh
source $HOME/.zshrc_modules/settings.sh

# syntax-highlighting (must be at the end of the file)
. /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="/Users/yevhenorlov/Library/Python/3.9/bin:$PATH"

loadenv() {
  set -o allexport
  source .dev
  set +o allexport
}
