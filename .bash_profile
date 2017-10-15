# general
function chrome() {
  open -a "Google Chrome" $1        
}
alias subl="sublime ."
alias vim="/usr/local/bin/vim"
alias grep="grep --color=auto"
alias ls="ls -G"
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# deco.agency (work stuff)
function dp() {
	cd ~/Documents/decoagency/$1/htdocs/wp-content/themes/$1
}
alias deco="cd ~/Documents/decoagency"

# weather and the moon
alias weather='curl -4 http://wttr.in/Kyiv'
alias moon='curl -4 http://wttr.in/Moon'

# editing and reloading bash profile
alias ebash='vim ~/.bash_profile'
alias rbash='. ~/.bash_profile'

# the fuck: magnifiscent app which corrects your previous console command (https://github.com/nvbn/thefuck)
eval "$(thefuck --alias)"

# pretty prompt (made easy with http://xta.github.io/HalloweenBash/)
function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' 
}
export PS1="\[\e[35;0m\]🕙  \d \t 🗂  \W\$(parse_git_branch)\[\e[0m\] 🚀  "

# color variables
DAWN='tput setaf 217'
NOON='tput setaf 117'
DUSK='tput setaf 93'

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
