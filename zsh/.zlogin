#
# This gets read fourth after zshrc for login shells
# Let's put stuff in here that's only used by human/login shells,
# which is most of my stuff
#
echo Hello from .zlogin

# TODO: move to .vimrc
EXINIT="set sw=4 showmatch redraw ai sh=/bin/sh|map!  {}O"

# TODO: make prompt colorful and dynamic
PS1='zsh> '

###  job control commands
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
alias f1='fg %1'
alias f2='fg %2'
alias f3='fg %3'
alias f4='fg %4'
alias f5='fg %5'


### forms of ls
if type exa > /dev/null ; then
    alias ll='exa --long --bytes --git'
    alias lwd='ll --sort=modified --reverse'
    alias lrd='ll --accessed --sort=accessed --reverse'
    # lhd should be a function to take args
    alias lhd='lwd --color=always | head'
else
    alais ll='ls -l'
    alias lwd='ls -t -l'
    alias lrd='ls -t -l -u'
    # lhd should be a function to take args
    alias lhd='ls -t -l | head'
fi

# TODO: directory management commands
# source "$DOT/dirs.bash"

### git stuff
# TODO: [[ -s "$ZDOTDIR/git-completion.zsh" ]] && source "$ZDOTDIR/git-completion.zsh"
alias gb='git branch'
alias gd='git diff'
alias gs='git status'
alias gfo='git fetch origin --no-tags'
alias gfu='git fetch upstream --no-tags'
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

### ruby stuff
# Prefer rbenv over rvm
if [ -d "$HOME/.rbenv" ] ; then
    eval "$(rbenv init -)"
else
    if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
        source "$HOME/.rvm/scripts/rvm"
    fi
fi
alias be='bundle exec'

### miscellaneous aliases
alias a='alias'
alias clr='clear'
alias cp='cp -i'
alias ge='env | grep -i'
alias mv='mv -i'
alias m='more'
alias ping=`whence ping`
alias rm='rm -i'
alias U='uptime'
alias vm='vi [Mm]akefile'
alias vt='vi -t'
