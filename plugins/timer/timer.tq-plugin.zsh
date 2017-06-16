local _default_time_table="\
21-24,0-3;🌙
12-14;🍚"
time_table="${time_table:=$_default_time_table}"

timer_main() {
    node "${PLUGIN_PATH}/timer/timer.js" "$time_table"
}