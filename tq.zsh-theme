#
# tq ZSH Theme
#
# Author: Tian Qi
# License: MIT
# https://github.com/kitian616/tq-zsh-theme

# Characters
TQ_BRANCH_SYMBOL="${TQ_BRANCH_SYMBOL:="\ue0a0"}"
TQ_FOOD_SYMBOL="${TQ_FOOD_SYMBOL:="🍚"}"
TQ_SSH_SYMBOL="${TQ_SSH_SYMBOL:="\ue0a2"}"
TQ_NIGHT_SYMBOL="${TQ_NIGHT_SYMBOL:="🌙"}"

# Privileges
TQ_PRIVILEGES_PREFIX="${TQ_PRIVILEGES_PREFIX:=""}"
TQ_PRIVILEGES_SUFFIX="${TQ_PRIVILEGES_SUFFIX:=""}"
TQ_PRIVILEGES_SYMBOL="${TQ_PRIVILEGES_SYMBOL:="=>"}"
TQ_PRIVILEGES_COLOR="${TQ_PRIVILEGES_COLOR:="green"}"
TQ_PRIVILEGES_STYLE="${TQ_PRIVILEGES_STYLE:="bold"}"

# User
TQ_USER_PREFIX="${TQ_USER_PREFIX:=""}"
TQ_USER_SUFFIX="${TQ_USER_SUFFIX:=""}"
TQ_USER_COLOR="${TQ_USER_COLOR:="yellow"}"
TQ_SUPERUSER_COLOR="${TQ_SUPERUSER_COLOR:="red"}"

# Tip
TQ_TIP_PREFIX="${TQ_TIP_PREFIX:=""}"
TQ_TIP_SUFFIX="${TQ_TIP_SUFFIX:=""}"
TQ_TIP_COLOR="${TQ_TIP_COLOR:="yellow"}"

# Dictionary
TQ_DICTIONARY_PREFIX="${TQ_DICTIONARY_PREFIX:=""}"
TQ_DICTIONARY_SUFFIX="${TQ_DICTIONARY_SUFFIX:=""}"
TQ_DICTIONARY_COLOR="${TQ_DICTIONARY_COLOR:="cyan"}"

# Git brance
TQ_GIT_BRANCE_PREFIX="${TQ_BRANCH_SYMBOL} "
TQ_GIT_BRANCE_SUFFIX="${TQ_GIT_BRANCE_SUFFIX:=""}"
TQ_GIT_BRANCE_COLOR="${TQ_GIT_BRANCE_COLOR:="magenta"}"

# Git status
TQ_GIT_STATUS_UNTRACKED="${TQ_GIT_STATUS_UNTRACKED:="?"}"
TQ_GIT_STATUS_ADDED="${TQ_GIT_STATUS_ADDED:="+"}"
TQ_GIT_STATUS_MODIFIED="${TQ_GIT_STATUS_MODIFIED:="!"}"
TQ_GIT_STATUS_RENAMED="${TQ_GIT_STATUS_RENAMED:="»"}"
TQ_GIT_STATUS_DELETED="${TQ_GIT_STATUS_DELETED:="✘"}"
TQ_GIT_STATUS_STASHED="${TQ_GIT_STATUS_STASHED:="$"}"
TQ_GIT_STATUS_UNMERGED="${TQ_GIT_STATUS_UNMERGED:="="}"
TQ_GIT_STATUS_AHEAD="${TQ_GIT_STATUS_AHEAD:="⇡"}"
TQ_GIT_STATUS_BEHIND="${TQ_GIT_STATUS_BEHIND:="⇣"}"

TQ_GIT_STATUS_PREFIX="${TQ_GIT_STATUS_PREFIX:="["}"
TQ_GIT_STATUS_SUFFIX="${TQ_GIT_STATUS_SUFFIX:="]"}"
TQ_GIT_STATUS_COLOR="${TQ_GIT_STATUS_COLOR:="red"}"

# Time
TQ_TIME_PREFIX="${TQ_TIME_PREFIX:="["}"
TQ_TIME_SUFFIX="${TQ_TIME_SUFFIX:="]"}"
TQ_TIME_COLOR="${TQ_TIME_COLOR:=""}"

# Exit code
TQ_EXIT_CODE_PREFIX="${TQ_EXIT_CODE_PREFIX:=""}"
TQ_EXIT_CODE_SUFFIX="${TQ_EXIT_CODE_SUFFIX:=""}"
TQ_EXIT_CODE_COLOR="${TQ_EXIT_CODE_COLOR:="red"}"

# ZSH theme git prompt setting
ZSH_THEME_GIT_PROMPT_UNTRACKED=$TQ_GIT_STATUS_UNTRACKED
ZSH_THEME_GIT_PROMPT_ADDED=$TQ_GIT_STATUS_ADDED
ZSH_THEME_GIT_PROMPT_MODIFIED=$TQ_GIT_STATUS_MODIFIED
ZSH_THEME_GIT_PROMPT_RENAMED=$TQ_GIT_STATUS_RENAMED
ZSH_THEME_GIT_PROMPT_DELETED=$TQ_GIT_STATUS_DELETED
ZSH_THEME_GIT_PROMPT_STASHED=$TQ_GIT_STATUS_STASHED
ZSH_THEME_GIT_PROMPT_UNMERGED=$TQ_GIT_STATUS_UNMERGED
ZSH_THEME_GIT_PROMPT_AHEAD=$TQ_GIT_STATUS_AHEAD
ZSH_THEME_GIT_PROMPT_BEHIND=$TQ_GIT_STATUS_BEHIND
ZSH_THEME_GIT_PROMPT_DIVERGED=$TQ_GIT_STATUS_DIVERGED

_get_pwd() {
    local git_root=$PWD
    while [[ $git_root != / && ! -e $git_root/.git ]]; do
        git_root=$git_root:h
    done
    if [[ $git_root == / ]]; then
        unset git_root
        prompt_short_dir=%~
    else
        parent=${git_root%\/*}
        prompt_short_dir=${PWD#$parent/}
    fi
    echo "$prompt_short_dir"
}

_get_date_string() {
    echo "$(date +%H:%M:%S)"
}

_get_hour() {
    echo "$(date +%H)"
}

# 0: is git
_is_git() {
  command git rev-parse --is-inside-work-tree &>/dev/null
  echo "$?"
}

# 0: is superuser
_is_superuser() {
    echo "$UID"
}

_get_prompt_section() {
    if [[ $# -eq 1 ]]; then
        echo "$1"
    elif [[ $# -eq 2 ]]; then
        echo "%{$fg[$2]%}$1%{$reset_color%}"
    elif [[ $# -eq 3 ]]; then
        echo "%{$fg[$2]$terminfo[$3]%}$1%{$reset_color%}"
    elif [[ $# -eq 4 ]]; then
        echo "%{$fg[$2]%}$terminfo[$3]$bg[$4]$1%{$reset_color%}"
    fi
}

# User
local prompt_user='$(_get_prompt_user)'
_get_prompt_user() {
    local superuser_or_not=$(_is_superuser)
    [[ $LOGNAME != $USER ]] || [[ $superuser_or_not -eq 0 ]] || [[ -n $SSH_CONNECTION ]] || return
    local prompt_text
    if [[ -n $SSH_CONNECTION ]]; then
        prompt_text=${TQ_USER_PREFIX}${USER}@$(hostname -s)${TQ_USER_SUFFIX}
    else
        prompt_text=${TQ_USER_PREFIX}${USER}${TQ_USER_SUFFIX}
    fi
    if [[ $superuser_or_not -eq 0 ]]; then
        echo "$(_get_prompt_section\
            $prompt_text\
            $TQ_SUPERUSER_COLOR\
            bold): "
    else
        echo "$(_get_prompt_section\
            $prompt_text\
            $TQ_USER_COLOR): "
    fi
}

# Privileges
local prompt_privileges="\
$(_get_prompt_section\
    ${TQ_PRIVILEGES_PREFIX}${TQ_PRIVILEGES_SYMBOL}${TQ_PRIVILEGES_SUFFIX}\
    ${TQ_PRIVILEGES_COLOR}\
    ${TQ_PRIVILEGES_STYLE})"

# Directory
local prompt_directory="\
$(_get_prompt_section\
    ${TQ_DICTIONARY_PREFIX}'$(_get_pwd)'${TQ_DICTIONARY_SUFFIX}\
    ${TQ_DICTIONARY_COLOR}) "

# Git brance
local prompt_git_brance='$(_get_prompt_git_brance)'
_get_prompt_git_brance() {
    [[ $(_is_git) -eq 0 ]] || return
    echo "$(_get_prompt_section\
        ${TQ_GIT_BRANCE_PREFIX}$(git_current_branch)${TQ_GIT_BRANCE_SUFFIX}\
        ${TQ_GIT_BRANCE_COLOR}) "
}

# Git satatus
local prompt_git_status='$(_get_prompt_git_status)'
_get_prompt_git_status() {
    local git_status=$(git_prompt_status)
    [[ $(_is_git) -eq 0 ]] && [[ -n $git_status ]] || return
    echo "$(_get_prompt_section\
        ${TQ_GIT_STATUS_PREFIX}${git_status}${TQ_GIT_STATUS_SUFFIX}\
        ${TQ_GIT_STATUS_COLOR}) "
}


# Exit code
local prompt_exit_code="\
%(?,,$(_get_prompt_section\
    ${TQ_EXIT_CODE_PREFIX}%?${TQ_EXIT_CODE_SUFFIX}\
    ${TQ_EXIT_CODE_COLOR}))"

# Time
local prompt_time="\
$(_get_prompt_section\
    ${TQ_TIME_PREFIX}'$(_get_date_string)'${TQ_TIME_SUFFIX}\
    ${TQ_TIME_COLOR}
)"

# Tip
local prompt_tip='$(_get_prompt_tip)'
_get_prompt_tip() {
    local hour=$(_get_hour)
    if [[ $hour -ge 12 ]] && [[ $hour -le 13 ]]; then
        echo "$(_get_prompt_section ${TQ_FOOD_SYMBOL} ${TQ_TIP_COLOR}) "
    elif [[ $hour -ge 21 ]] || [[ $hour -le 3 ]]; then
        echo "$(_get_prompt_section ${TQ_NIGHT_SYMBOL} ${TQ_TIP_COLOR}) "
    fi
}

PROMPT="
$prompt_user\
$prompt_directory\
$prompt_git_brance\
$prompt_git_status
$prompt_exit_code\
$prompt_privileges"

RPROMPT="\
$prompt_tip\
$prompt_time\
"