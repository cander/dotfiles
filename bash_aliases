

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# my stuff
set -o vi
export EDITOR=vim
screen -list

alias   j='jobs -l'
function    f   { fg %"$*"; }
function    fj {
    jobs -l
    print -n "Select Job #: "
    typeset jn="job"
    read jn
    fg %"$jn"
}


alias   U='uptime'
alias   m=more
alias clr='clear'
alias cp='cp -i'
alias f1='fg %1'
alias f2='fg %2'
alias f3='fg %3'
alias f4='fg %4'
alias f5='fg %5'
alias lwd='ls -t -l'
# lhd should be a function to take args
alias lhd='ls -t -l | head'
alias mv='mv -i'
alias rm='rm -i'
alias source='.'
alias which='type'

#
#  set directory switching commands
#       sd ----- switch to a new dircetory
#       bk ----- switch back to the old directory
#       pd ----- push the current directory onto the stack and switch to new one
#       pp ----- pop directory off the stack and switch to it
#	d ------ select a directory from the directory stack
#	rd ------ remember directory stack
#	pmt ---- updates the prompt (defined in ".kseterm")
#

# alias pmt=true

function	cd	{ 
    command cd $@ > /dev/null
    # pmt
}

#alias cd='sd'

alias	bk='cd -'
function pd {
    pushd "$1"
    # pmt
}
function pp {
    popd
    # pmt
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
                # pmt
            fi
	    ;;

	*) echo "Unknown entry: $n" ;;
    esac
}

#alias	rd='print $dirs:$PWD > $DOT/savedirs/${HOST}'

# This loads RVM into a shell session
[[ -s "/home/canderson/.rvm/scripts/rvm" ]] && source "/home/canderson/.rvm/scripts/rvm"  
