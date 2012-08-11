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
# Helper functions to set up a fancy prompt.
#
# Best way to use it is just to copy it anywhere you want (likely a
# hidden directory in your home) and source it from .bashrc or .profile.
# In terminal emulators other than bash, you can use the dot operator
# (`. fancy_prompt.sh`) instead of `source`.
#
# Basic .bashrc:
#
#  source .my_scripts/fancy_prompt.sh
#
# Possible prompts:
#
#   ~ $ _  # Home at local machine
#   ~/src/project (project.git:my-branch)$ _  # GitHub repository
#   username@machine ~/src/project (https://url.com/project.git)  # SSH
#   ~/src/project (branch)  # git project showing only the current branch

SHOW_REMOTE=true  # Show the origin remote url
SHOW_BRANCH=true  # Show the current branch name
CROP_GITHUB_URL=true  # Hide the github domain from the github url
CROP_GITHUB_USERNAME=true  # Hide the github username from the github url
CROP_GIT_TAIL=true  # Hide the ".git" from git urls
#SHOW_USERNAME_AND_MACHINE=true  # Always show username@machine
SHOW_UNPUSHED_COMMIT_COUNT=true  # Show count of commits ahead of remotes
SHOW_UNCOMMITED=true  #  Show an asterisk if there are uncommited changes


function set_custom_prompt {

  local NO_COLOR="\[\033[0m\]"

  local BLACK="\[\033[0;30m\]"
  local RED="\[\033[0;31m\]"
  local GREEN="\[\033[0;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local BLUE="\[\033[0;34m\]"
  local MAGENTA="\[\033[0;35m\]"
  local CYAN="\[\033[0;36m\]"
  local WHITE="\[\033[0;37m\]"

  local BOLD_BLACK="\[\033[1;30m\]"
  local BOLD_RED="\[\033[1;31m\]"
  local BOLD_GREEN="\[\033[1;32m\]"
  local BOLD_YELLOW="\[\033[1;33m\]"
  local BOLD_BLUE="\[\033[1;34m\]"
  local BOLD_MAGENTA="\[\033[1;35m\]"
  local BOLD_CYAN="\[\033[1;36m\]"
  local BOLD_WHITE="\[\033[1;37m\]"

  local BG_BLACK="\[\033[40m\]"
  local BG_RED="\[\033[41m\]"
  local BG_GREEN="\[\033[42m\]"
  local BG_YELLOW="\[\033[43m\]"
  local BG_BLUE="\[\033[44m\]"
  local BG_MAGENTA="\[\033[45m\]"
  local BG_CYAN="\[\033[46m\]"
  local BG_WHITE="\[\033[47m\]"

  local USERNAME_COLOR=$YELLOW
  local MACHINE_COLOR=$RED
  local REMOTE_COLOR=$BLUE
  local BRANCH_COLOR=$CYAN
  local UNPUSHED_COMMITS_COUNT_COLOR=$YELLOW
  local SHOW_UNCOMMITED_COLOR=$RED

  local HIGHLIGHT=$BLACK$BG_RED

  PS1="\w"  # By default, show current working directory

  if is_ssh
  then  # Add username@machine at start of prompt when it's an ssh session
    PS1="$USERNAME_COLOR\u$NO_COLOR@$MACHINE_COLOR\h$NO_COLOR:$PS1"
  fi

  if [ "$SHOW_REMOTE" ] || [ "$SHOW_BRANCH" ]
  then  # Display when inside a git repository
    PS1="$PS1\`if is_git; then echo \ \(; fi\`"
    if [ "$SHOW_REMOTE" ]
    then  # Display "origin" remote git repository
      PS1="$PS1$REMOTE_COLOR\`if is_git; then echo \$(git_remote); fi\`"
    fi
    if [ "$SHOW_REMOTE" ] && [ "$SHOW_BRANCH" ]
    then  # When displaying both the remote repository and
          # the branch, show separator
      # If there is no remote set, don't display divisory :
      PS1="$PS1$NO_COLOR\`if is_git && [ \$(git_remote) ]; then echo \:; fi\`"
    fi
    if [ "$SHOW_BRANCH" ]
    then  # Display current branch
      PS1="$PS1$BRANCH_COLOR\`if is_git; then echo \$(current_git_branch); fi\`"
      if [ "$SHOW_UNPUSHED_COMMIT_COUNT" ]
      then
        PS1="$PS1$UNPUSHED_COMMITS_COUNT_COLOR\`if is_git; then echo [\$(commit_count)]; fi\`"
      fi
    fi
    if [ "$SHOW_UNCOMMITED" ]
    then
      PS1="$PS1$SHOW_UNCOMMITED_COLOR\`if is_git && uncommited_changes; then echo \*; fi\`"
    fi
    PS1="$PS1\`if is_git; then echo $NO_COLOR\) ; fi\`"
  fi

  PS1="$PS1$NO_COLOR\$ "  # Reset custom color codes that might have been setup
}

function is_git {
  if [ -d .git ] || [ $(git rev-parse --git-dir 2>/dev/null) ]
  then
    if [ -z "$(grep \.git.*$ <<< $PWD)" ]
    then
      return 0
    fi
  fi
  return 1
}

function current_git_branch {
  echo `git branch | grep \* | tr -d '* '`
}

function commit_count {
  echo `git log --branches --not --remotes --oneline | wc -l`
}

function uncommited_changes {
  if [ "$(git status -s)" ]
  then
    return 0
  fi
  return 1
}

function git_remote {
  # Git remote url
  local GIT_REMOTE=`git remote -v |
      grep origin.*fetch |
      sed "s/origin//" |
      sed "s/(fetch)//" |
      tr -d ' \t'`

  if [ "$CROP_GITHUB_URL" ]
  then
    if [ "$CROP_GITHUB_USERNAME" ]
    then  # Display only remote repository name without username
      GIT_REMOTE=${GIT_REMOTE#https*github\.com\/*\/}
    else  # Display only remote repository name if it is GitHub
      GIT_REMOTE=${GIT_REMOTE#https*github\.com\/}
    fi
  fi
  if [ "$CROP_GIT_TAIL" ]
  then  # Display only remote repository name if it is GitHub
    GIT_REMOTE=${GIT_REMOTE%\.git}
  fi

  echo $GIT_REMOTE
}

function is_ssh {
  # Detect if current session was initiated from SSH.
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ] ||
      [ -n "$SHOW_USERNAME_AND_MACHINE" ]
  then
    return 0
  fi
  return 1
}


set_custom_prompt


unset SHOW_REMOTE SHOW_BRANCH REMOTE_BRANCH_SEPARATOR
unset SHOW_USERNAME_AND_MACHINE
unset SHOW_UNPUSHED_COMMIT_COUNT
