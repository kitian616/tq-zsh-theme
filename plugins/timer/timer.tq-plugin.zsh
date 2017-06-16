##
# timer plugin for tq-zsh-theme
#
# Author: Tian Qi

# Settings
# - TQ_TIMER_TIME_TABLE

local default_time_table="\
21-24,0-3;🌙
12-14;🍚"
TQ_TIMER_TIME_TABLE="${TQ_TIMER_TIME_TABLE:=$default_time_table}"

timer_main() {
    node "${PLUGIN_PATH}/timer/timer.js" "$TQ_TIMER_TIME_TABLE"
}