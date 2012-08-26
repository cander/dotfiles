#
#  set directory switching commands
#       sd ----- switch to a new dircetory
#       bk ----- switch back to the old directory
#       pd ----- push the current directory onto the stack and switch to new one
#       pp ----- pop directory off the stack and switch to it
#	d ------ select a directory from the directory stack
#	rd ------ remember directory stack
#

function	cd	{ 
    command cd $@ > /dev/null
}

#alias cd='sd'

alias	bk='cd -'
function pd {
    pushd "$1"
}
function pp {
    popd
}

function d {
    # print a menu
    if [ $# -eq 0 ] 
    then
        # dirs -v -l does most of this except zero-base list
        echo " 1) $PWD"
        i=1
        while [ $i -lt  ${#DIRSTACK[@]} ]
        do
                ii=$((i+1))
                # expand ~ into the full path
            echo " $ii) ${DIRSTACK[$i]/~/$HOME}"
            i=$ii
        done
            IFS=${OFS}
        echo -n "Select Directory: "
        read n
    else
        n=$1
    fi

    # go to the new directory by popping it out of the stack and pushing it
    case ${n:-EMPTY} in
	EMPTY | 0 | 1) ;;
	[0-9]*)
            if [ $n -le ${#DIRSTACK[@]} ]
            then
                n=$((n-1))
                newdir=${DIRSTACK[$n]}
                # popd (and pushd) print the stack - annoying
                popd +$n
                # replace ~ with the directory and quote newdir in case it
                # contains spaces
                pushd "${newdir/~/$HOME}"
            fi
	    ;;

	*) echo "Unknown entry: $n" ;;
    esac
}

#alias	rd='print $dirs:$PWD > $DOT/savedirs/${HOST}'
