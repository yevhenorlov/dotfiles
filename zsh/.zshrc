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


# export NVM_DIR="$HOME/.nvm"
#   [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="/Users/yevhenorlov/Library/Python/3.9/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

export GOROOT=$(brew --prefix go)/libexec
export PATH=$PATH:$GOROOT/bin

loadenv() {
  set -o allexport
  source .dev
  set +o allexport
}
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"

# syntax-highlighting (must be at the end of the file)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
