# Open in Chrome
function chrome() {
  open -a "Google Chrome" $1
}

# Open in Firefox Dev Edition
function ff() {
  open -a "Firefox Developer Edition" $1
}

# npm install --save-dev shortcut
function npmid() {
  npm install --save-dev $1
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
  tree -I '.git|node_modules|.DS_Store' --dirsfirst --filelimit 15 -L ${1:-3} -aC $2
}

alias vim="nvim"
alias grep="grep --color=auto"
alias ls="ls -G" 
alias pop="osascript -e 'display notification \"Done\" with title \"CLI\"'"
alias pomodoro="~/code/pomodoro-go/pomodoro && pop"
alias pcs="node ~/code/perfect-circuit-scraper/index.js"
alias ns="npm start"
alias cdc="cdd ~/code"
alias cddj="cdd ~/code/djinn"
alias cddf="cdd ~/code/dotfiles"
alias an="vim ~/code/notes/infinite-note.md"

# docker djinni
alias psql="docker exec -ti \`docker ps --filter "name=pgdb" --filter "status=running" -q\` psql --user djinn djinn"
alias pgdb="docker exec -ti \`docker ps --filter "name=pgdb" --filter "status=running" -q\` bash"
alias web="docker exec -ti \`docker ps --filter "name=web" --filter "status=running" -q\` bash"

# time, weather and the moon
alias time='date +"%T"'
alias weather='curl -4 http://wttr.in/Kyiv'
alias moon='curl -4 http://wttr.in/Moon'

# editing and reloading zsh
alias ezsh='vim ~/.zshrc'
alias rzsh='. ~/.zshrc'

# editing init.vim
alias evim='vim ~/.config/nvim/init.vim'

# editing alacritty.yml
alias ealac='vim ~/.config/alacritty/alacritty.yml'

# editing tmux.conf
alias etmux='vim ~/.tmux.conf'

# dnd

function gn() {
npx run-func getName.js getName $1 $2
}
