#
# site specific initializations


export CVSROOT=~/CVSROOT
export CVS_RSH=ssh
SHELL=/usr/bin/bash

PATH="$PATH:/usr/libexec"
export JAVA_HOME=`java_home`
export GRAILS_HOME=/usr/local/java/grails-1.2.1
PATH="$PATH:$GRAILS_HOME/bin"
PATH="$PATH:/usr/local/java/groovy-1.7.0/bin"

#PATH="$PATH:/usr/local/src/scala-2.7.7.final/bin"
PATH="$PATH:/usr/local/git/bin"
MANPATH="$MANPATH:/usr/local/git/share/man"

#export OPENWINHOME=/usr/openwin
#export TEXINPUTS=".:/opt/texmf/tex/latex/unpacked:/usr/local/tex/noweb"
export PYTHONPATH="/Users/admin/research/py:/Users/admin/research/misc-py"

#eval `~/shbin/remote-host.pl`

# Fink stuff
if [ -r /sw/bin/init.sh ] 
then 
    . /sw/bin/init.sh 
fi

if [ -r /usr/local/bin/virtualenvwrapper_bashrc ]
then 
    source /usr/local/bin/virtualenvwrapper_bashrc
fi

export CSLTCOMM_HOME=/usr/local/java/ConsultComm-3.0
#export ANT_HOME=/usr/local/java/apache-ant-1.5.4
export CLICOLOR=1   # ls colors on mac

export CDPATH=".:..:~:~/dev/gravit"
alias vim='/Applications/vim/Vim.app/Contents/MacOS/Vim'
alias jython='/usr/local/java/jython-2.1/jython'
alias java14='echo setting JDK to 1.4 ; export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.4/Home'

alias gradle='/usr/local/java/gradle-0.9.2/bin/gradle'
export HADOOP_HOME=/usr/local/java/hadoop-0.20.2+320
PATH=$PATH:$HADOOP_HOME/bin
PATH=$PATH:/Users/charles/.gem/ruby/1.8/bin

[[ -s "/Users/charles/.rvm/scripts/rvm" ]] && source "/Users/charles/.rvm/scripts/rvm"  

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
