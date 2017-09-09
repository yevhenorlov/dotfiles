# general
alias subl="sublime ."
alias vim="/usr/local/bin/vim"

# git
alias ga="git add -A"
alias gc="git commit"
alias gp="git pull"
alias gs="git status"
alias gl="git log"

# deco.agency (work stuff)
alias deco="cd ~/Documents/decoagency"
alias dp="decoproj"

# weather and the moon
alias weather='curl -4 http://wttr.in/Kyiv'
alias moon='curl -4 http://wttr.in/Moon'

# editing and reloading bash profile
alias ebash='vim ~/.bash_profile'
alias rbash='. ~/.bash_profile'

# the fuck: magnifiscent app which corrects your previous console command (https://github.com/nvbn/thefuck)
eval "$(thefuck --alias)"

# functions
function decoproj() {
	cd ~/Documents/decoagency/$1/htdocs/wp-content/themes/$1
}

# pretty prompt (made easy with http://xta.github.io/HalloweenBash/)
function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' 
}
export PS1="\[\e[35;0m\]🕙  \d \t 🗂  \W\$(parse_git_branch)\[\e[0m\] 🚀  "

# prompt greeting
h=`date +%H`
if [ $h -lt 12 ]; then
  TIMEOFDAY="morning"
elif [ $h -lt 18 ]; then
  TIMEOFDAY="afternoon"
else
  TIMEOFDAY="evening"
fi
echo "$(tput setaf 2)Good ${TIMEOFDAY}, Yevhen.$(tput sgr0)"
