# modules
source $HOME/.zshrc_modules/fzf.sh
source $HOME/.zshrc_modules/tmux.sh
source $HOME/.zshrc_modules/paths.sh
source $HOME/.zshrc_modules/theme.sh
source $HOME/.zshrc_modules/plugins.sh
source $ZSH/oh-my-zsh.sh
source $HOME/.zshrc_modules/aliases.sh
source $HOME/.zshrc_modules/settings.sh

# syntax-highlighting (must be at the end of the file)
. /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
