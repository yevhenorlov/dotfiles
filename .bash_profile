# Enable tab completion
source ~/.bash-git-config/git-completion.bash

# Change command prompt
source ~/.bash-git-config/git-prompt.sh

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

alias subl="sublime ."
alias vim="/usr/local/bin/vim"
alias grep="grep --color=auto"
alias ls="ls -G"
alias pop="osascript -e 'display notification \"Done\" with title \"CLI\"'"
alias pomodoro="~/code/pomodoro-go/pomodoro"
alias nrd="npm run dev"
alias cdc="cd ~/code"

# time, weather and the moon
alias time='date +"%T"'
alias weather='curl -4 http://wttr.in/Kyiv'
alias moon='curl -4 http://wttr.in/Moon'

# editing and reloading bash profile
alias ebash='vim ~/.bash_profile'
alias rbash='. ~/.bash_profile'

# editing vimrc
alias evim='vim ~/.vimrc'

# the fuck: magnifiscent app which corrects your previous console command (https://github.com/nvbn/thefuck)
eval "$(thefuck --alias)"

# pretty prompt

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1="\[\033[0;94m\]\W\[\033[0;96m\]\$(__git_ps1) 🐇 \[\033[0m\] "

# color variables
DAWN='tput setaf 168'
NOON='tput setaf 48'
DUSK='tput setaf 62'

# prompt greeting
h=`date +%H`
if [ $h -lt 12 ]; then
  TIMEOFDAY="morning"
  COLOR=${DAWN}
elif [ $h -lt 18 ]; then
  TIMEOFDAY="afternoon"
  COLOR=${NOON}
else
  TIMEOFDAY="evening"
  COLOR=${DUSK}
fi
echo "$(${COLOR})Good ${TIMEOFDAY}, Yevhen.$(tput sgr0)"


# tiny-care-terminal
# ------------------

# List of accounts to read the last tweet from, comma separated
# The first in the list is read by the party parrot.
export TTC_BOTS='tinycarebot,selfcare_bot,magicrealismbot'

# Use this to have a different animal say a message in the big box.
export TTC_SAY_BOX='parrot'

# List of folders to look into for `git` commits, comma separated.
export TTC_REPOS='~/Documents/decoagency,~/GitHub'

# The max directory-depth to look for git repositories in
# the directories defined with `TTC_REPOS`. Note that the deeper
# the directory depth, the slower the results will be fetched.
export TTC_REPOS_DEPTH=2

# Which method is to be used to read the git commits ('gitstandup' | 'gitlog').
# If you're having problems seeing your commits in the dahsboard, set
# this value to gitlog.
export TTC_GITBOT='gitlog'

# Location/zip code to check the weather for. Both 90210 and "San Francisco, CA"
# _should_ be ok (the zip code doesn't always work -- use a location
# first, if you can). It's using weather.service.msn.com behind the curtains.
export TTC_WEATHER='Kyiv'

# Set to false if you're an imperial lover <3
export TTC_CELSIUS=true

# Unset this if you _don't_ want to use Twitter keys and want to
# use web scraping instead.
export TTC_APIKEYS=false

# Refresh the dashboard every 20 minutes.
export TTC_UPDATE_INTERVAL=20

# Turn off terminal title
export TTC_TERMINAL_TITLE=false

# # Twitter api keys
# export TTC_CONSUMER_KEY='...'
# export TTC_CONSUMER_SECRET='...'
# export TTC_ACCESS_TOKEN='...'
# export TTC_ACCESS_TOKEN_SECRET='...'
#
# # Note: in tiny-terminal-care < 1.0.7, the recommended variables for the Twitter
# # API keys were the ones before. As of 1.0.8, they are deprecated
# # (because the names are too generic), but will still be supported
# # until the next major version.
# export CONSUMER_KEY='...'
# export CONSUMER_SECRET='...'
# export ACCESS_TOKEN='...'
# export ACCESS_TOKEN_SECRET='...'
