#
# set terminal dependent things for the profile script
#   prompt
#   TERMCAP
#
#
#

HOMECRT=vt100
WORKCRT=vt100

# set up terminal type and tty options

#
# Emulate tset command
#
if [ -z "$TERM" -o "$TERM" = "unknown" ]
then
    if port=`tty`
    then
	case $port in
	    /dev/console )
		term=vt100 ;;
	    /dev/tty[pqrt]? | /dev/pt[sy]/* )
		term=xterm ;;
	    * )
		term=$WORKCRT ;;
	esac
    else
	term="unknown"
    fi
else
    # TERM is set - use it
    term=$TERM
fi

echonl "TERM = ($term) "  1>&2
read line

if [ -n "$line" ]
then
    term=$line
fi

export TERM ; TERM=$term


stty -nl tostop kill  erase  intr  

function setPS1 { 
    # TODO is there a bash way to substring this down?
    pstr=`echo ${PWD} | \
    awk '{if (length($0) > 35) \
	    print "..." substr($0, length($0) - 30); \
	  else print $0 }'`

    PS1="[${HOST}] $pstr " 
}

if [ "$TERM" = "xterm" -o "$TERM" = "xterm-color" -o "$TERM" = \'xterm\' ]
then
    TERM=xterm
    unset TERMCAP
    if whence resize > /dev/null 2>&1
    then
        eval `resize`
        export TERMCAP
    else
        echo "Cannot find resize.  Setting TERM to xterms (80x24)"
        export TERM=xterms
    fi

    function xname { echo "]0;$1"; }
    # xname $HOST
    function xtitle { echo -n "]2;$1"; }
    function pmt {
        setPS1
        xtitle "$HOST:$PWD"
    }
else
    function pmt {
        setPS1
    }
fi
