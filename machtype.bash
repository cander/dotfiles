#
#	Try to figure out what kind of machine we're running on.  Set
#	PATH accordingly
#

# Mac and Linux have their own ways of colorizing ls, so we reluctantly have
# to deal with that in here
alias ls='ls -CF'

UNAME=`uname`
case $UNAME in
    Darwin)
        # add some mechanism to search /Applications and /Developer
        PATH=$GENERIC_PATH
        MANPATH=$GENERIC_MANPATH
	if [ -d /opt/homebrew/bin ] ; then
	    # homebrew on ARM installs in a different directory, and I've had some build problems
	    PATH=$PATH:/opt/homebrew/bin
	    MANPATH=$MANPATH:/opt/homebrew/share/man/
	    # perhaps this should use brew --prefix
	    if [ -d /opt/homebrew/opt/libffi ] ; then
	      export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
	      export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
	      export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"

	    fi
	fi
        export CLICOLOR=1   # ls colors on mac
        export LSCOLORS='fxCxgxdxbxegedabagacad'
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
