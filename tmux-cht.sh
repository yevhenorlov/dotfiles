#!/usr/bin/env bash

languages=$(echo "c clojure cpp css git golang html javascript rust tmux typescript" | tr " " "\n")
core_utils=$(echo "awk chmod curl find ls sed xargs" | tr " " "\n") 
selected=$(echo -e "$languages\n$core_utils" | fzf)

read -p "GIMME QUERY: " query

if echo "$languages"| grep -qs $selected; then
  # I AM LANGUAGE
  tmux split-window -h bash -c "curl cht.sh/$selected/$(echo "$query" | tr " " "+") | less"
else
  # I AM CORE UTIL
  curl cht.sh/$selected~$query
fi
