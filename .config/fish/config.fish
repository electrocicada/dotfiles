if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
set -e KITTY_SHELL_INTEGRATION

alias config='/usr/bin/git --git-dir=/home/electrocicada/.cfg/ --work-tree=/home/electrocicada'

#vim))
alias vmi='vim'
alias imv='vim'
alias ivm='vim'
alias mvi='vim'
alias miv='vim'


#clear
alias c='clear'

#replase ls via exa
alias ll='exa -lahH'
alias ls='exa -F'

#quick thunar call
alias tn='thunar'

#sh ~/bars
export EDITOR=vim
export GOPATH=$HOME/go

theme_gruvbox dark hard
