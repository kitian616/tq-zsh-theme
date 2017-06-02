#
# tq ZSH Theme
#
# Author: Tian Qi
# License: MIT
# https://github.com/kitian616/tq-zsh-theme

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

# Characters
DAK_FOOD_EMOJI="☕️"
DAK_NIGHT_EMOJI="🌙"

DAK_FOOD_CHAR="☕︎"
DAK_NIGHT_CHAR="☽"

DAK_GIT_SYMBOL="\ue0a0"
DAK_FOOD_SYMBOL=$DAK_FOOD_CHAR
DAK_FOOD_SYMBOL_COLOR="yellow"
DAK_NIGHT_SYMBOL=$DAK_NIGHT_CHAR
DAK_NIGHT_SYMBOL_COLOR="yellow"

# Privileges
DAT_PRIVILEGES_SYMBOL="=>"
DAT_PRIVILEGES_COLOR="green"
DAT_PRIVILEGES_STYLE="bold"

# User
DAT_USER_PREFIX=""
DAT_USER_SUFFIX=""
DAT_USER_COLOR="yellow"
DAT_SUPERUSER_COLOR="red"

# Tip
DAT_TIP_PREFIX=""
DAT_TIP_SUFFIX=""
DAT_TIP_COLOR="blue"

# Dictionary
DAT_DICTIONARY_PREFIX=""
DAT_DICTIONARY_SUFFIX=""
DAT_DICTIONARY_COLOR="cyan"

# Git brance
DAT_GIT_BRANCE_PREFIX="${DAK_GIT_SYMBOL} "
DAT_GIT_BRANCE_SUFFIX=""
DAT_GIT_BRANCE_COLOR="magenta"

# Git status
DAT_GIT_STATUS_UNTRACKED="${DAT_GIT_STATUS_UNTRACKED:="?"}"
DAT_GIT_STATUS_ADDED="${DAT_GIT_STATUS_ADDED:="+"}"
DAT_GIT_STATUS_MODIFIED="${DAT_GIT_STATUS_MODIFIED:="!"}"
DAT_GIT_STATUS_RENAMED="${DAT_GIT_STATUS_RENAMED:="»"}"
DAT_GIT_STATUS_DELETED="${DAT_GIT_STATUS_DELETED:="✘"}"
DAT_GIT_STATUS_STASHED="${DAT_GIT_STATUS_STASHED:="$"}"
DAT_GIT_STATUS_UNMERGED="${DAT_GIT_STATUS_UNMERGED:="="}"
DAT_GIT_STATUS_AHEAD="${DAT_GIT_STATUS_AHEAD:="⇡"}"
DAT_GIT_STATUS_BEHIND="${DAT_GIT_STATUS_BEHIND:="⇣"}"

DAT_GIT_STATUS_PREFIX="["
DAT_GIT_STATUS_SUFFIX="]"
DAT_GIT_STATUS_COLOR="red"

# Time
DAT_TIME_PREFIX="["
DAT_TIME_SUFFIX="]"
DAT_TIME_COLOR=""

# Exit code
DAT_EXIT_CODE_PREFIX=""
DAT_EXIT_CODE_SUFFIX=""
DAT_EXIT_CODE_COLOR="red"

# ZSH_THEME_GIT_PROMPT_SETTING
ZSH_THEME_GIT_PROMPT_UNTRACKED=$DAT_GIT_STATUS_UNTRACKED
ZSH_THEME_GIT_PROMPT_ADDED=$DAT_GIT_STATUS_ADDED
ZSH_THEME_GIT_PROMPT_MODIFIED=$DAT_GIT_STATUS_MODIFIED
ZSH_THEME_GIT_PROMPT_RENAMED=$DAT_GIT_STATUS_RENAMED
ZSH_THEME_GIT_PROMPT_DELETED=$DAT_GIT_STATUS_DELETED
ZSH_THEME_GIT_PROMPT_STASHED=$DAT_GIT_STATUS_STASHED
ZSH_THEME_GIT_PROMPT_UNMERGED=$DAT_GIT_STATUS_UNMERGED
ZSH_THEME_GIT_PROMPT_AHEAD=$DAT_GIT_STATUS_AHEAD
ZSH_THEME_GIT_PROMPT_BEHIND=$DAT_GIT_STATUS_BEHIND
ZSH_THEME_GIT_PROMPT_DIVERGED=$DAT_GIT_STATUS_DIVERGED

# User
local prompt_user='$(_get_prompt_user)'
_get_prompt_user() {
    local superuser_or_not=$(_is_superuser)
    [[ $LOGNAME != $USER ]] || [[ $superuser_or_not -eq 0 ]] || [[ -n $SSH_CONNECTION ]] || return
    if [[ $superuser_or_not -eq 0 ]]; then
        echo "$(_get_prompt_section\
            ${DAT_USER_PREFIX}${USER}${DAT_USER_SUFFIX}\
            ${DAT_SUPERUSER_COLOR}\
            bold): "
    else
        echo "$(_get_prompt_section\
            ${DAT_USER_PREFIX}${USER}${DAT_USER_SUFFIX}\
            ${DAT_USER_COLOR}): "
    fi
}

# Privileges
local prompt_privileges="\
$(_get_prompt_section\
    ${DAT_PRIVILEGES_SYMBOL}\
    ${DAT_PRIVILEGES_COLOR}\
    ${DAT_PRIVILEGES_STYLE}) "

# Directory
local prompt_directory="\
$(_get_prompt_section\
    ${DAT_DICTIONARY_PREFIX}'$(_get_pwd)'${DAT_DICTIONARY_SUFFIX}\
    ${DAT_DICTIONARY_COLOR}) "

# Git brance
local prompt_git_brance='$(_get_prompt_git_brance)'
_get_prompt_git_brance() {
    local git_or_not=$(_is_git)
    [[ $git_or_not -eq 0 ]] || return
    echo "$(_get_prompt_section\
        ${DAT_GIT_BRANCE_PREFIX}$(git_current_branch)${DAT_GIT_BRANCE_SUFFIX}\
        ${DAT_GIT_BRANCE_COLOR}) "
}

# Git satatus
local prompt_git_status='$(_get_prompt_git_status)'
_get_prompt_git_status() {
    local git_or_not=$(_is_git)
    local git_status=$(git_prompt_status)
    [[ $git_or_not -eq 0 ]] && [[ -n $git_status ]] || return
    echo "$(_get_prompt_section\
        ${DAT_GIT_STATUS_PREFIX}${git_status}${DAT_GIT_STATUS_SUFFIX}\
        ${DAT_GIT_STATUS_COLOR}) "
}


# Exit code
local prompt_exit_code="\
%(?,,$(_get_prompt_section\
    ${DAT_EXIT_CODE_PREFIX}%?${DAT_EXIT_CODE_SUFFIX}\
    ${DAT_EXIT_CODE_COLOR}))"

# Time
local prompt_time="\
$(_get_prompt_section\
    ${DAT_TIME_PREFIX}'$(_get_date_string)'${DAT_TIME_SUFFIX}\
    ${DAT_TIME_COLOR}
)"

# Tip
local prompt_tip='$(_get_prompt_tip)'
_get_prompt_tip() {
    local hour=$(_get_hour)
    if [[ $hour -ge 12 ]] && [[ $hour -le 13 ]]; then
        echo "$(_get_prompt_section ${DAK_FOOD_SYMBOL} ${DAK_FOOD_SYMBOL_COLOR}) "
    elif [[ $hour -ge 21 ]] || [[ $hour -le 3 ]]; then
        echo "$(_get_prompt_section ${DAK_NIGHT_SYMBOL} ${DAK_NIGHT_SYMBOL_COLOR}) "
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
