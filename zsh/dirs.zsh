#
# Commands for moving around directories
#

export CDPATH=.:..:~    # default - maybe change in site.zsh
alias  bk='cd -'
alias  pd='pushd'
alias  pp='popd'

# select a directory from the printed directory stack
function d {
    local n
    if [ $# -eq 0 ]
    then
        # print a one-based list of the directory stack
        dirs  -p | cat -n
        echo -n "Select Directory: "
        read n
    else
        n=$1
    fi

    case ${n:-EMPTY} in
	EMPTY | 0 | 1) ;;   # no-op
	[0-9]*)
        pushd .         # pushing . will save cwd and makes list effectively 1-based
        cd +$n || popd  # if cd fails, un-push cwd to restore previous state
        ;;
    esac
}

# TODO - would this be useful to resurrect - save dirs? Not per-host, though
#alias	rd='print $dirs:$PWD > $DOT/savedirs/${HOST}'
