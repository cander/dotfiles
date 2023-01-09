#
# This gets read second after zshenv for most shells
#

GENERIC_PATH=.:~/shbin:/usr/local/bin:/usr/local/sbin:/usr/local/shbin:/bin:/sbin:/usr/bin:/usr/sbin
GENERIC_MANPATH=/usr/man:/usr/local/man:/usr/share/man:/usr/local/share/man

# Figure out what kind of machine we're on
if [ -r $DOT/machtype.bash ]
then
    . $DOT/machtype.bash
else
    echo "$DOT/machtype.bash does not exist!  Defaulting PATH."
    PATH=$GENERIC_PATH
fi

SHELL=`whence bash`
HOST=`hostname`

# Set JAVA_HOME on a Mac if Java is installed
[ -x /usr/libexec/java_home ] && /usr/libexec/java_home > /dev/null 2>&1 && export JAVA_HOME=$(/usr/libexec/java_home)


# optional things to add to PATH
[[ -d ~/go/bin ]] && PATH="$PATH:~/go/bin"
[[ -d /usr/local/go/bin ]] && PATH="$PATH:/usr/local/go/bin"
[[ -d /usr/local/git/bin ]] && PATH="$PATH:/usr/local/git/bin"
[[ -d /usr/local/mysql/bin ]] && PATH="$PATH:/usr/local/mysql/bin"


[[ -r $ZDOTDIR/site.zsh ]] && source $ZDOTDIR/site.zsh

export PATH
