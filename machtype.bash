#
#	Try to figure out what kind of machine we're running on.  Set
#	PATH accordingly
#

# Mac and Linux have their own ways of colorizing ls, so we reluctantly have
# to deal with that in here
alias ls='ls -CF'

UNAME=`uanme`
case $UNAME in
    Darwin)
        # add some mechanism to search /Applications and /Developer
        PATH=$GENERIC_PATH:/sw/bin:/sw/sbin
        MANPATH=$GENERIC_MANPATH:/sw/share/man:/sw/lib/perl5/5.8.6/man
        export CLICOLOR=1   # ls colors on mac
        # Fink stuff
        if [ -r /sw/bin/init.sh ] 
        then 
            . /sw/bin/init.sh 
        fi
        ;;
    SunOS)
        # from collab root env
        PATH=$GENERIC_PATH:/root/bin:/usr/ucb:/etc:/usr/ccs/bin:/usr/include:/opt/sfw/bin/:/usr/sfw/bin/
        MANPATH=$GENERIC_MANPATH:/opt/sfw/man
        ;;
    Linux)
        PATH=$GENERIC_PATH:/usr/kerberos/bin
        MANPATH=$GENERIC_MANPATH
        alias ls='ls --color=tty -CF'
        ;;
    FreeBSD)
        PATH=.:$GENERIC_PATH
        MANPATH=$GENERIC_MANPATH
        ;;
    *)
        PATH=$GENERIC_PATH
        MANPATH=$GENERIC_MANPATH
        UNAME="unknown"
        ;;
esac

export PATH MANPATH

# Maybe a mechanism to prune missing dirs from PATH?
# Maybe some generic mechanism to locate common tools like jython, java,
# ant, etc.
