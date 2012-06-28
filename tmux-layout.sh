
if [ "$1" = "" ]
then
    echo "Usage: $0 [name|dir]"
    exit 1
fi
name=$1

TMP=/tmp/tmux-test-$$.out
( cd $name 2> $TMP )
if [ -s $TMP ]
then
    start_dir=''
else
    start_dir=$name
    name=$(basename $name)
fi

echo "name: $name  --  start_dir: $start_dir"

tmux new-session -s $name -d
tmux split-window -h -l 80
# need to quit asking for TERM, then:
if [ -n "$start_dir" ]
then
    tmux send-keys -t $name:1.1 "cd $start_dir" C-m
    tmux send-keys -t $name:1.2 "cd $start_dir" C-m
fi

tmux attach -t $name
