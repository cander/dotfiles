#
#	Baroque bash shell enviornment for cander
#

# this script uses some auxilary files if they exist
#	dotfiles/machtype.bash	determine the machine type and set PATH
#	~/.kdir		directory stack of last session (created in .klogout)
#	~/dotfiles/setterm.bash	set up the terminal type
#	~/.k_HOSTNAME	machine specific items for HOSTNAME
#	~/.klogout	sourced on logout or exit.
#
# history and directory stack are kept on a per machine basis in:
#	~/.khistory_HOSTNAME
#	~/.kdir_HOSTNAME

DOT=$HOME/dotfiles
cd
alias whence='type -path'
alias which='type'
alias print='echo'

GENERIC_PATH=.:~/shbin:/usr/local/bin:/usr/local/sbin:/usr/local/shbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin
GENERIC_MANPATH=/usr/man:/usr/local/man:/usr/share/man:/usr/local/share/man

# Figure out what kind of machine we're on
if [ -r $DOT/machtype.bash ] 
then
    . $DOT/machtype.bash
else
    echo "$DOT/machtype.bash does not exist!  Defaulting PATH."
    PATH=$GENERIC_PATH
fi


# set appropriate shell variables
loggedin=${loggedin:=0}
set -o vi -o monitor -o ignoreeof

EDITOR=`whence vi`
FCEDIT=`whence vi`
HISTSIZE=500
SHELL=`whence bash`
# We assume that ENV is set to .profile in .vueprofile.  Otherwise we
# are a login shell in which case we are running .profile beacuse of
# being invoked as -ksh.  Either way, we don't want to source .profile on
# every subsequent shell (like a shell escape) so unset ENV
#ENV=$HOME/.profile
unset ENV

# HOST is the official name of this host 
HOST=`hostname`
# Don't really want history in DOT, which is under hg, and I'm not running
# NFS now.  Let it default. In the future, if the files are in a
# directory, make sure the directory exists.
#HISTFILE=$DOT/histories/$HOST.bash
# environment setups for vi and my name for mail
EXINIT="set sw=4 showmatch redraw ai sh=/bin/sh|map!  {}O"
NAME="Charles Anderson"
#
#  set job control commands
#	j ------ list current jobs in long format
#       f ------ put named job into foreground
#	fj ----- foreground selected job (prompts with list of jobs)
alias	j='jobs -l'
function	f	{ fg %"$*"; }
function	fj {
    jobs -l
    print -n "Select Job #: "
    typeset jn="job"
    read jn
    fg %"$jn"
}

#
#   set history mechanism commands
#
#	r ---------- repeat last command
#	h ---------- list the last 10 commands executed
#	hs --------- select a command from the last 30 (needs the program cmd)
#	s PT1 PT2 -- substitute first occurence of PT1 for PT2 in last command
#       sg RE1 RE2 - substitute ALL occurences of RE1 for RE2 in last
#                    command and then print and execute. (No quoting.)
#
alias   r='fc -s'
alias	h='fc -l -10'
function	hs	{
    fc -l -n -r -29 | colrm 1 8 | cat -n -v | pr -t -l10 -3 | colrm 80
    typeset -i n
    read n?"Select Command #: "
    print -n "{$n}k" | cmd
}
#function	s	{ fc -e - $1=$2 ; }
function	sg	{
    fc -nl -1 -1 | sed -e "s/^[ 	]*//" -e "s^$1^$2^g" | cmd ; }
#
#  set file listing commands
#	ls ---- list files distinguishing directories and executables (ls -CF)
#	le ---- list files in directory and execute command on selected file
#
alias ls='ls -CF'
#
#  miscellaneous commands
#
#	M ------- make
#	ME ------ make > E.o 2>&1
# 	rME ----- do a ME on a remote machine 
#	U ------- uptime
#	rl ------ rlogin with back quote eacape char
#	R ------- ruptime
#	m ------- more
#	rt ------ reset terminal
#	vg ------ vi files matching a pattern
#	vt ------ vi looking for a specific tag
#
alias	M=gmake
alias	ME='gmake > E.o 2>&1'
function	ME	{
    if (( $# >= 1 ))
	then gmake $* > E.o 2>&1
	else gmake > E.o 2>&1
    fi
}
function	rME	{
    if (( $# == 0 ))
	then 
	    echo "Usage: rME host [target]..."
	    return 1
    fi
    host=$1
    shift
    env="export PATH=$PATH ; export TOP_LEVEL=$TOP_LEVEL ; export ARCH=$ARCH"
    if (( $# >= 1 ))
	then rsh $host "$env ; cd $PWD ; gmake $* > $host.E.o 2>&1 " </dev/null &
	else rsh $host "$env ; cd $PWD ; gmake > $host.E.o 2>&1 " </dev/null &
    fi
    unset env
}
function	PE	{ pmake $* > E.o 2>&1 ; }

alias	U='uptime'
alias	m=more
alias	rt='stty -nl erase  kill  intr '
alias	vt='vi -t'
function	vg	{
    if (( $# <= 2 ))
	then 
	    echo "Usage: vg pattern file..."
	    return 1
    fi
    pat=$1
    shift
    files=`egrep -l $pat $*`
    if [ -n "$files" ] ; then
	vi +/"$pat" $files
    else
	echo "No match for pattern: $pat"
    fi
}

# Figure how how to echo with a newline
n=`echo -n foo | wc -l`
if [ $n -eq 0 ]
then
    function echonl { 
	echo -n $@ 
    }
else
    function echonl { 
	echo "$@\c" 
    }
fi

if [ -r $DOT/setterm.bash ] ; 
then 
    . $DOT/setterm.bash
else
    echo "No $DOT/setterm.bash file!"
    stty -nl erase  kill  intr 
    function pmt { PS1="[${HOST}]${PWD}: "; }
fi

#
# set up for logout
#
if [ -r $DOT/logout.ksh ] 
then 
    trap ". $DOT/logout.ksh" 0 
fi
#
loggedin=1
typeset -x PATH MANPATH  EDITOR EXINIT NAME SHELL TERM TERMCAP USER
umask 2

# Things from the csh environment +etc
alias a='alias'
alias clr='clear'
alias cp='cp -i'
alias f1='fg %1'
alias f2='fg %2'
alias f3='fg %3'
alias f4='fg %4'
alias f5='fg %5'
alias logout=". ~/.klogout ; exit"
alias lrd='ls -t -l -u'
alias lwd='ls -t -l'
# lhd should be a function to take args
alias lhd='ls -t -l | head'
alias me='pd $HOME'
alias mv='mv -i'
alias ping=`whence ping`
alias rm='rm -i'
alias source='.'
alias which='type'
alias vm='vi [Mm]akefile'
alias be='bundle exec'
alias rehash='hash -r'


# directory management commands
source "$DOT/dirs.bash"

# git stuff
[[ -s "$DOT/git-completion.bash" ]] && source "$DOT/git-completion.bash"
alias gb='git branch'
alias gs='git status'
alias gfo='git fetch origin --no-tags'
function	gpf {
    # this could look for remote and branch parameters, I only do this
    # for origin and the current branch
    # in git 1.8, don't need awk: git symbolic-ref --short -q HEAD
    if branch=$(git symbolic-ref -q HEAD)
    then
        branch=$(echo $branch | awk -F / '{print $NF}')
        echo "git pull --ff-only origin $branch"
        git pull --ff-only origin $branch
    else
        echo "not on any branch - can't fast-forward"
    fi
}

# look for optional packages that have their own configuration
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

[[ -s /usr/local/bin/virtualenvwrapper_bashrc ]] && source /usr/local/bin/virtualenvwrapper_bashrc

[ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion

[ -x /usr/libexec/java_home ] && /usr/libexec/java_home > /dev/null 2>&1 && export JAVA_HOME=$(/usr/libexec/java_home)

# things in /usr/local to add to PATH
[[ -d /usr/local/git/bin ]] && PATH="$PATH:/usr/local/git/bin"
[[ -d /usr/local/mysql/bin ]] && PATH="$PATH:/usr/local/mysql/bin"

if [ -r $DOT/site.sh ]
then
    . $DOT/site.sh
fi

export PATH
