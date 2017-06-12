BASE_PATH="$(dirname $0:A)"
_time_table=$1
_default_time_table="\
21-24,0-3;🌙
12-14;🍚"
_time_table="${_time_table:=$_default_time_table}"

node "$BASE_PATH/timer.js" "$_time_table"