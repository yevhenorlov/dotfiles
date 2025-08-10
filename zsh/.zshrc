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

loadenv() {
  set -o allexport
  source .dev
  set +o allexport
}
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"

# syntax-highlighting (must be at the end of the file)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/yevhenorlov/.opam/opam-init/init.zsh' ]] || source '/Users/yevhenorlov/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
