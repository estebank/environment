#!/bin/bash
#             DO WHATEVER YOU WANT TO PUBLIC LICENSE 
#                    Version 1, December 2012
# 
#  Copyright (C) 2012 Esteban Kuber <esteban@kuber.com.ar> 
# 
#  Everyone is permitted to copy and distribute verbatim or modified 
#  copies of this script. 
# 
#    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 
# 
#   0. You just DO WHATEVER YOU WANT TO.
#
#
# .bashrc contents.
# 
# Basic .bashrc:
#
#  source .my_scripts/bashrc.sh
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# some more aliases
alias ls='ls -FG'
alias ll='ls -alFG'
alias la='ls -AG'
alias l='ls -CFG'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export EDITOR='vim'

# Keep history through shells
shopt -s histappend

# Fancy prompt
if [ -f ~/.myscripts/fancy_prompt.sh ]; then
    . ~/.myscripts/fancy_prompt.sh
fi
