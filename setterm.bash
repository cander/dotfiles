#
# set terminal dependent things for the profile script
#

# No longer bother to figure out what type of TERM we're on - modern OSes
# seem to set TERM correctly

stty -nl tostop kill  erase  intr  

# map current directory into preferred form for PS1
function short_pwd { 
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
        echo ${pwd}
    else
        echo "...${pwd: -32:32}"
    fi
}

# set a fancy color prompt if possible
case "$TERM" in
    xterm-color)
        PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]$(short_pwd)\[\033[00m\] '
    ;;
    screen*)
        # someday use unique color scheme for screen
        PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]$(short_pwd)\[\033[00m\] '
    ;;
    *)
        export PS1='\u@\h: $(short_pwd) '
    ;;
esac

# NB: machtype.bash sets up ls colors based on machine type

# TODO - set color flag and alias grep, etc.
#        removed code to set title in xterm-like termals via pmt function

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

