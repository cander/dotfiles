#
# site specific initializations
# PATH gets set here based on MACH_PATH_HEAD and MACH_PATH_TAIL (from
# machtype.sh) and GENERIC_PATH (from profile.sh)
#
PATH=$MACH_PATH_HEAD:$GENERIC_PATH:$MACH_PATH_TAIL

#MANPATH="/usr/local/man:/usr/man:/opt/CZtcsh/man:/opt/FSFemacs/man:/opt/FSFgcc/man:/opt/FSFgzip/man:/opt/FSFlibg++/man:/opt/WLtop/man:/opt/texmf/doc/man:/opt/matlab/man:/opt/FSFbash/man:/opt/GNUperl/man:/opt/FSFrcs/man:/opt/FSFgmake/man"

# invoke host specific stuff here

# do machine dependent stuff for this machine type
if [ -r ~/.k_${MACHTYPE} ]
then 
    . ~/.k_${MACHTYPE}
fi

# do machine dependent stuff for this host
if [ -r ~/.k_${HOST} ] 
then 
    . ~/.k_${HOST} 
fi

export CVSROOT=~/CVSROOT
export CVS_RSH=ssh
SHELL=/usr/bin/bash

export JAVA_HOME=/usr

#export OPENWINHOME=/usr/openwin
#export TEXINPUTS=".:/opt/texmf/tex/latex/unpacked:/usr/local/tex/noweb"
export PYTHONPATH="/Users/admin/research/py:/Users/admin/research/misc-py"

eval `~/shbin/remote-host.pl`

# Fink stuff
if [ -r /sw/bin/init.sh ] 
then 
    . /sw/bin/init.sh 
fi

export CSLTCOMM_HOME=/usr/local/java/ConsultComm-3.0
export ANT_HOME=/usr/local/java/apache-ant-1.5.4
export CLICOLOR=1   # ls colors on mac

export CDPATH=".:~:~/Synched"
alias vim='/Applications/vim/Vim.app/Contents/MacOS/Vim'
alias jython='/usr/local/java/jython-2.1/jython'
alias java14='echo setting JDK to 1.4 ; export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.4/Home'
