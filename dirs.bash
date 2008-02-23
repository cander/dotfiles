#
#  set directory switching commands
#       sd ----- switch to a new dircetory
#       bk ----- switch back to the old directory
#       pd ----- push the current directory onto the stack and switch to new one
#       pp ----- pop directory off the stack and switch to it
#	d ------ select a directory from the directory stack
#	rd ------ remember directory stack
#	pmt ---- updates the prompt (defined in ".kseterm")

function	sd	{ 
    command cd $@ > /dev/null
    pmt
}

alias cd='sd'

alias	bk='sd -'

function	pd	{
    if [ $# -gt 0 ] ; then
	if cd $1 > /dev/null 
	then
	    dirs="$dirs $OLDPWD"
	fi
    else
	if pp 
	then
	    dirs="$dirs $OLDPWD"
	    fi
    fi 
}

function	pp	{
    case ${dirs:-EMPTY} in
	EMPTY)
	    print directory stack is empty >&2
	    unset dirs
	    return 1;;
	*)
	    #echo "Start: $dirs"
	    typeset d="${dirs% *}"
	    newdirs=${dirs#$d }

	    #echo "Next1: newdirs: $newdirs, d: $d"

	    if [ "$d" = "$dirs" ]
	    then
	    	dirs=""
	    else
		dirs=$newdirs
	    fi

	    #echo "Next2 dirs: $dirs, d: $d"
	    cd $d
    esac
}


function d {
    # print a menu
    if [ $# -eq 0 ] 
    then
	i=1
	for dir in $PWD $dirs
	do
	    echo " $i) $dir"
	    i=$[$i + 1]
	done
	echo -n "Select Directory: "
	read n
    else
	n=$1
    fi

    # go to the new directory
    case ${n:-EMPTY} in
	EMPTY | 1 | 0) ;;
	[0-9]*)
	    i=2
	    dest=EMPTY
	    newdirs="$PWD"
	    # find the new directory and compute new dir stack
	    for dir in $dirs
	    do
		if [ $i -eq $n ]
		then
		    dest=$dir
		else
		    newdirs="$newdirs $dir"
		fi

		i=$[$i + 1]
	    done

	    case $dest in
		EMPTY)	echo "Invalid directory choice" ;;
		*)	cd $dest
			dirs=$newdirs ;;
	    esac
	    ;;

	*) echo pd $d ;;
    esac
}

alias	rd='print $dirs:$PWD > $DOT/savedirs/${HOST}'
