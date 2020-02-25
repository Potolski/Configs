# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/david/.oh-my-zsh"
export EDITOR=emacsclient
export PATH="$PATH:/home/david/flutter/flutter/bin"
export PATH="$PATH:/home/david/Downloads/android-studio/bin/studio.sh"

ZSH_THEME="agnoster"

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    sudo

)

source $ZSH/oh-my-zsh.sh
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
eval `dircolors ~/.dir_colors/dircolors`

prompt_context() {}

source /home/david/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /home/david/zsh-interactive-cd.plugin.zsh
# Bash script file
#
# Author:        Filipe L B Correia <filipelbc@gmail.com>
# Last Change:   2019 Apr 16 11:00:36
#
# About:         functions for directory listing after cd'ing

#===============================================================================
# Options:

list_show_hidden=0  # don't show hidden files
list_show_details=0 # don't show files' details
list_show_sizes=0   # don't show files' sizes

if [ -n "$has_color" ]; then
    list_color_normal="\033[0m"
    list_color_line="\033[0m"
    list_color_dir="\033[1;31m"
fi

#===============================================================================
# Helpers:

list_hidden () {
    list_show_hidden=$(( 1 - $list_show_hidden ))
    list
}

list_details () {
    list_show_details=$(( 1 - $list_show_details ))
    list
}

list_sizes () {
    list_show_sizes=$(( 1 - $list_show_sizes ))
    list
}

list_get_full_path () {
    if [ -d "$1" ]; then
        pushd "$1" >/dev/null
        pwd
        popd >/dev/null
    fi
}

list_print_line () {
    c="─"
    if [ "$#" -eq 1 ]; then
        c=$1
    fi

    echo -en $list_color_line
    for i in $(seq 1 $COLUMNS); do echo -n $c; done
    echo -e $list_color_normal
}

list_print_ls () {
    o=""

    if [ $list_show_details -eq 1 ]; then
        o="$o -lh"
    elif [ $list_show_sizes -eq 1 ]; then
        o="$o -sh"
    fi

    if [ $list_show_hidden -eq 1 ]; then
        o="$o -A"
    fi

    ls $o "$1"
}

list_print_pwd () {
    list_print_line
    list_print_ls "$(pwd)"
}

list_print_dir () {
    list_print_line
    p=$(list_get_full_path "$1")
    echo -e $list_color_dir$p$list_color_normal
    list_print_line "-"
    list_print_ls "$p"
}

list_clear () {
    echo -e '\033[H\033[2J'
}

#===============================================================================
# Main:

list () {
    list_clear
    # list current directory if no argument is given
    if [ "$#" -eq 0 ]; then
        list_print_pwd
    else
        # list given directories
        for dir in "$@"
        do
            if [ -d "$dir" ]; then
                list_print_dir "$dir"
            fi
        done
    fi
    list_print_line
}

# call after cd'ing
PROMPT_COMMAND='[ "${list_wd=$PWD}" != "$PWD" ] && list; list_wd=$PWD'

#===============================================================================
# Aliases:

alias l='list'
alias :hi='list_hidden'
alias :de='list_details'
alias :si='list_sizes'
alias plantuml='java -jar ~/java/plantuml.jar'

###  AUTOJUMP  ###
[[ -s /home/david/.autojump/etc/profile.d/autojump.sh ]] && source /home/david/.autojump/etc/profile.d/autojump.sh

autoload -U compinit && compinit -u

##################
