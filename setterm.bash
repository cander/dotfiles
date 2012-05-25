#
# set terminal dependent things for the profile script
#   prompt
#   TERMCAP
#
#
#


# No longer bother to figure out what type of TERM we're on - modern OSes
# seem to set TERM correctly

stty -nl tostop kill  erase  intr  

function setPS1 { 
    # try to remove $HOME as prefix
    pwd="${PWD#~}"
    if [ "$PWD" != "$pwd" ]
    then
        # we're under or in $HOME - collapse, unless its only $HOME
        if [ "$PWD" == "$HOME" ]
        then
            pwd="$HOME"
        else
            # put ~ literal back in
            pwd='~'$pwd
        fi
    fi

    # truncate pwd down to 32 characters, if needed
    if [ "${pwd:0:32}" == "$pwd" ]
    then
        PS1="[\h:${pwd}] " 
    else
        PS1="[\h: ...${pwd: -32:32}] " 
    fi

    # are there some standard ways to handle colors in prompts?
    # see the Ubuntu stock bashrc file
}

if [ "$TERM" = "xterm" -o "$TERM" = "xterm-color" ]
then
    #TERM=xterm
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
