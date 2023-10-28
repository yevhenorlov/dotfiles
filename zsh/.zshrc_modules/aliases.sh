# Open in Chrome
function chrome() {
  open -a "Google Chrome" $1
}

# npm install --save-dev shortcut
function npmid() {
  npm install --save-dev $1
}

# load file into node.js repl
noderepl() {
    FILE_CONTENTS="$(< $1 )"
    node -i -e "$FILE_CONTENTS"
}

# Change directory and list its content
function cdd() {
  printf "\n"
  cd $1 && ls -Ga
  printf "\n"
}

# Tree with sensible defaults 
# (brew install tree first)
function t() {
  # Defaults to 3 levels deep, do more with `t 5` or less with `t 1`
  # Pass additional args after
  tree -I '.git|node_modules|.DS_Store' --dirsfirst --filelimit 150 -L ${1:-3} -aC $2
}

alias cdc="cdd ~/code"
alias cddf="cdd ~/code/dotfiles"
alias grep="grep --color=auto"
alias ls="ls -G" 
alias nb="npm run build"
alias nd="npm run dev"
alias ns="npm start"
alias pomodoro="~/code/pomodoro-go/pomodoro && pop"
alias pop="osascript -e 'display notification \"Done\" with title \"CLI\"'"
alias vim="nvim"
alias gpt="~/chatgpt.sh"

alias nuke_modules="find . -name node_modules -type d -prune -exec trash {} +"

# time, weather and the moon
alias time='date +"%T"'
alias weather='curl -4 http://wttr.in/Uithoorn'
alias moon='curl -4 http://wttr.in/Moon'

# editing and reloading zsh
alias ezsh='vim ~/.zshrc'
alias rzsh='. ~/.zshrc'

# editing init.vim
alias evim='vim ~/.config/nvim/init.vim'

# editing tmux.conf
alias etmux='vim ~/.tmux.conf'

# work
# GlobalProtect
alias gpoff="launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"
alias gpon="launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"
alias cdcn="cdd ~/code/cn"
alias cdjss="cdd ~/code/cn/jss-frontend"
alias cdwww="cdd ~/code/cn/www-frontend"

# Where should I put you?
bindkey -s ^F "tmux-sessionizer\n"
